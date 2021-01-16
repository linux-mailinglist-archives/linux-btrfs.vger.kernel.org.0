Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608142F8E1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbhAPRGL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 12:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbhAPQbV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 11:31:21 -0500
X-Greylist: delayed 1357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Jan 2021 08:18:51 PST
Received: from smtp.steev.me.uk (smtp.steev.me.uk [IPv6:2001:8b0:162c:10::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A7C06135F
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 08:18:51 -0800 (PST)
Received: from [2001:8b0:162c:2:13:ad86:21fd:8844]
        by smtp.steev.me.uk with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.93.0.4)
        id 1l0nvr-00Bw8z-Q6
        for linux-btrfs@vger.kernel.org; Sat, 16 Jan 2021 15:56:07 +0000
From:   Steven Davies <btrfs-list@steev.me.uk>
Subject: [PATCH RFC] btrfs-progs: receive-dump, add JSON output format
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <ddaea074-c805-0d52-8336-8c91a20f659d@steev.me.uk>
Date:   Sat, 16 Jan 2021 15:56:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have seen a few requests from users on other forums for a way to find a diff between two 
snapshots and some scripts have been created[1] which parse a btrfs-send stream to get this 
information.

This patch adds native JSON format output support to the btrfs-receive dump command which would 
make writing such scripts much easier as they can use JSON parsing libraries rather than string 
or binary decoding.

Usage: btrfs send --no-data <subvolume> | btrfs receive --dump-json

Sample output:
[
  {"operation": "subvol", "path": "./2021-01-16T03:01:36+00:00", "uuid": 
"4f6756a2-c8e8-614b-beaa-483de9a7ed13", "transid": 47864957},
  {"operation": "chown", "path": "./2021-01-16T03:01:36+00:00/", "gid": 0, "uid": 0},
  {"operation": "chmod", "path": "./2021-01-16T03:01:36+00:00/", "mode": "755"},
  {"operation": "utimes", "path": "./2021-01-16T03:01:36+00:00/", "atime": 
"2021-01-16T03:00:30+0000", "mtime": "1970-01-01T01:00:00+0100", "ctime": 
"2021-01-13T03:00:38+0000"},
  {"operation": "mkdir", "path": "./2021-01-16T03:01:36+00:00/o257-2524-0"},
  {"operation": "rename", "path": "./2021-01-16T03:01:36+00:00/o257-2524-0", "dest": 
"./2021-01-16T03:01:36+00:00/grub"},
  {}
]

Patch is against current btrfs-progs master.

[1] https://github.com/sysnux/btrfs-snapshots-diff

Signed-off-by: Steven Davies <btrfs@steev.me.uk>
---
  cmds/receive-dump.c | 268 +++++++++++++++++++++++++++++++++++++++++-----------
  cmds/receive-dump.h |   1 +
  cmds/receive.c      |  20 +++-
  3 files changed, 234 insertions(+), 55 deletions(-)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 648d9314..2c1af22e 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -51,7 +51,7 @@
   * Returns the length of the escaped characters. Unprintable characters are
   * escaped as octals.
   */
-static int print_path_escaped(const char *path)
+static int print_path_escaped(const char *path, int json)
  {
  	size_t i;
  	size_t path_len = strlen(path);
@@ -61,27 +61,44 @@ static int print_path_escaped(const char *path)
  		char c = path[i];

  		len++;
-		switch (c) {
-		case '\a': putchar('\\'); putchar('a'); len++; break;
-		case '\b': putchar('\\'); putchar('b'); len++; break;
-		case '\e': putchar('\\'); putchar('e'); len++; break;
-		case '\f': putchar('\\'); putchar('f'); len++; break;
-		case '\n': putchar('\\'); putchar('n'); len++; break;
-		case '\r': putchar('\\'); putchar('r'); len++; break;
-		case '\t': putchar('\\'); putchar('t'); len++; break;
-		case '\v': putchar('\\'); putchar('v'); len++; break;
-		case ' ':  putchar('\\'); putchar(' '); len++; break;
-		case '\\': putchar('\\'); putchar('\\'); len++; break;
-		default:
-			  if (!isprint(c)) {
-				  printf("\\%c%c%c",
-						  '0' + ((c & 0300) >> 6),
-						  '0' + ((c & 070) >> 3),
-						  '0' + (c & 07));
-				  len += 3;
-			  } else {
-				  putchar(c);
-			  }
+		if (!json) {
+			switch (c) {
+			case '\a': putchar('\\'); putchar('a'); len++; break;
+			case '\b': putchar('\\'); putchar('b'); len++; break;
+			case '\e': putchar('\\'); putchar('e'); len++; break;
+			case '\f': putchar('\\'); putchar('f'); len++; break;
+			case '\n': putchar('\\'); putchar('n'); len++; break;
+			case '\r': putchar('\\'); putchar('r'); len++; break;
+			case '\t': putchar('\\'); putchar('t'); len++; break;
+			case '\v': putchar('\\'); putchar('v'); len++; break;
+			case ' ':  putchar('\\'); putchar(' '); len++; break;
+			case '\\': putchar('\\'); putchar('\\'); len++; break;
+			default:
+				  if (!isprint(c)) {
+					  printf("\\%c%c%c",
+							  '0' + ((c & 0300) >> 6),
+							  '0' + ((c & 070) >> 3),
+							  '0' + (c & 07));
+					  len += 3;
+				  } else {
+					  putchar(c);
+				  }
+			}
+		} else {
+			if (c < 0x20) {
+				printf("\\u%04x", c);
+				len += 5;
+			} else if (c == '\\') {
+				putchar('\\');
+				putchar('\\');
+				len++;
+			} else if (c == '"') {
+				putchar('\\');
+				putchar('"');
+				len++;
+			} else {
+				putchar(c);
+			}
  		}
  	}
  	return len;
@@ -109,22 +126,41 @@ static int __print_dump(int subvol, void *user, const char *path,
  		out_path = full_path;
  	}

-	/* Unified header */
-	printf("%-16s", title);
-	ret = print_path_escaped(out_path);
-	if (!fmt) {
+
+	if (!r->json) {
+		/* Unified header */
+		printf("%-16s", title);
+		ret = print_path_escaped(out_path, r->json);
+		if (!fmt) {
+			putchar('\n');
+			return 0;
+		}
+		/* Short paths are aligned to 32 chars; longer paths get a single space */
+		do {
+			putchar(' ');
+		} while (++ret < 32);
+		va_start(args, fmt);
+		/* Operation specified ones */
+		vprintf(fmt, args);
+		va_end(args);
  		putchar('\n');
-		return 0;
-	}
-	/* Short paths are aligned to 32 chars; longer paths get a single space */
-	do {
+	} else {
+		/* Unified header */
+		printf(" {\"operation\": \"%s\", \"path\": \"", title);
+		ret = print_path_escaped(out_path, r->json);
+		putchar('"');
+		if (!fmt) {
+			printf("},\n");
+			return 0;
+		}
+		putchar(',');
  		putchar(' ');
-	} while (++ret < 32);
-	va_start(args, fmt);
-	/* Operation specified ones */
-	vprintf(fmt, args);
-	va_end(args);
-	putchar('\n');
+		va_start(args, fmt);
+		/* Operation specified ones */
+		vprintf(fmt, args);
+		va_end(args);
+		printf("},\n");
+	}
  	return 0;
  }

@@ -140,11 +176,18 @@ static int print_subvol(const char *path, const u8 *uuid, u64 ctransid,
  			void *user)
  {
  	char uuid_str[BTRFS_UUID_UNPARSED_SIZE];
+	struct btrfs_dump_send_args *r = user;

  	uuid_unparse(uuid, uuid_str);

-	return PRINT_DUMP_SUBVOL(user, path, "subvol", "uuid=%s transid=%llu",
-				 uuid_str, ctransid);
+	if (!r->json) {
+		return PRINT_DUMP_SUBVOL(user, path, "subvol",
+			"uuid=%s transid=%llu", uuid_str, ctransid);
+	} else {
+		return PRINT_DUMP_SUBVOL(user, path, "subvol",
+			"\"uuid\": \"%s\", \"transid\": %llu",
+			uuid_str, ctransid);
+	}
  }

  static int print_snapshot(const char *path, const u8 *uuid, u64 ctransid,
@@ -154,14 +197,23 @@ static int print_snapshot(const char *path, const u8 *uuid, u64 ctransid,
  	char uuid_str[BTRFS_UUID_UNPARSED_SIZE];
  	char parent_uuid_str[BTRFS_UUID_UNPARSED_SIZE];
  	int ret;
+	struct btrfs_dump_send_args *r = user;

  	uuid_unparse(uuid, uuid_str);
  	uuid_unparse(parent_uuid, parent_uuid_str);

-	ret = PRINT_DUMP_SUBVOL(user, path, "snapshot",
-		"uuid=%s transid=%llu parent_uuid=%s parent_transid=%llu",
+	if (r->json) {
+		ret = PRINT_DUMP_SUBVOL(user, path, "snapshot",
+			"uuid=%s transid=%llu parent_uuid=%s parent_transid=%llu",
  				uuid_str, ctransid, parent_uuid_str,
  				parent_ctransid);
+	} else {
+		ret = PRINT_DUMP_SUBVOL(user, path, "snapshot",
+			"\"uuid\": \"%s\", \"transid\": %llu, \"parent_uuid\": \"%s\", \
+			\"parent_transid\": %llu",
+				uuid_str, ctransid, parent_uuid_str,
+				parent_ctransid);
+	}
  	return ret;
  }

@@ -177,8 +229,16 @@ static int print_mkdir(const char *path, void *user)

  static int print_mknod(const char *path, u64 mode, u64 dev, void *user)
  {
-	return PRINT_DUMP(user, path, "mknod", "mode=%llo dev=0x%llx", mode,
-			  dev);
+	struct btrfs_dump_send_args *r = user;
+
+	if (!r->json) {
+		return PRINT_DUMP(user, path, "mknod", "mode=%llo dev=0x%llx",
+			  mode, dev);
+	} else {
+		return PRINT_DUMP(user, path,
+			  "mknod", "\"mode\": \"%llo\", \"dev\": \"0x%llx\"",
+			  mode, dev);
+	}
  }

  static int print_mkfifo(const char *path, void *user)
@@ -203,12 +263,26 @@ static int print_rename(const char *from, const char *to, void *user)
  	int ret;

  	PATH_CAT_OR_RET("rename", full_to, r->full_subvol_path, to, ret);
-	return PRINT_DUMP(user, from, "rename", "dest=%s", full_to);
+	if (!r->json) {
+		ret = PRINT_DUMP(user, from, "rename", "dest=%s", full_to);
+	} else {
+		ret = PRINT_DUMP(user, from, "rename", "\"dest\": \"%s\"",
+			  full_to);
+	}
+	return ret;
  }

  static int print_link(const char *path, const char *lnk, void *user)
  {
-	return PRINT_DUMP(user, path, "link", "dest=%s", lnk);
+	struct btrfs_dump_send_args *r = user;
+	int ret;
+
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path, "link", "dest=%s", lnk);
+	} else {
+		ret = PRINT_DUMP(user, path, "link", "\"dest\": \"%s\"", lnk);
+	}
+	return ret;
  }

  static int print_unlink(const char *path, void *user)
@@ -224,8 +298,18 @@ static int print_rmdir(const char *path, void *user)
  static int print_write(const char *path, const void *data, u64 offset,
  		       u64 len, void *user)
  {
-	return PRINT_DUMP(user, path, "write", "offset=%llu len=%llu",
+	struct btrfs_dump_send_args *r = user;
+	int ret;
+
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path, "write", "offset=%llu len=%llu",
+			  offset, len);
+	} else {
+		ret = PRINT_DUMP(user, path,
+			  "write", "\"offset\": %llu, \"len\": %llu",
  			  offset, len);
+	}
+	return ret;
  }

  static int print_clone(const char *path, u64 offset, u64 len,
@@ -239,37 +323,93 @@ static int print_clone(const char *path, u64 offset, u64 len,

  	PATH_CAT_OR_RET("clone", full_path, r->full_subvol_path, clone_path,
  			ret);
-	return PRINT_DUMP(user, path, "clone",
+
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path, "clone",
  			  "offset=%llu len=%llu from=%s clone_offset=%llu",
  			  offset, len, full_path, clone_offset);
+	} else {
+		ret = PRINT_DUMP(user, path, "clone",
+			  "\"offset\": %llu, \"len\": %llu, \"from\": \"%s\""
+			  ", \"clone_offset\": %llu",
+			  offset, len, full_path, clone_offset);
+	}
+	return ret;
  }

  static int print_set_xattr(const char *path, const char *name,
  			   const void *data, int len, void *user)
  {
-	return PRINT_DUMP(user, path, "set_xattr", "name=%s data=%.*s len=%d",
+	struct btrfs_dump_send_args *r = user;
+	int ret;
+
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path,
+			  "set_xattr", "name=%s data=%.*s len=%d",
+			  name, len, (char *)data, len);
+	} else {
+		ret = PRINT_DUMP(user, path,
+			  "set_xattr", "\"name\": \"%s\""
+			  ", \"data\": \"%.*s\", \"len\": %d",
  			  name, len, (char *)data, len);
+	}
+	return ret;
  }

  static int print_remove_xattr(const char *path, const char *name, void *user)
  {
+	struct btrfs_dump_send_args *r = user;
+	int ret;

-	return PRINT_DUMP(user, path, "remove_xattr", "name=%s", name);
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path, "remove_xattr", "name=%s", name);
+	} else {
+		ret = PRINT_DUMP(user, path, "remove_xattr",
+			  "\"name\": \"%s\"", name);
+	}
+	return ret;
  }

  static int print_truncate(const char *path, u64 size, void *user)
  {
-	return PRINT_DUMP(user, path, "truncate", "size=%llu", size);
+	struct btrfs_dump_send_args *r = user;
+	int ret;
+
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path, "truncate", "size=%llu", size);
+	} else {
+		ret = PRINT_DUMP(user, path, "truncate", "\"size\": %llu", size);
+	}
+	return ret;
  }

  static int print_chmod(const char *path, u64 mode, void *user)
  {
-	return PRINT_DUMP(user, path, "chmod", "mode=%llo", mode);
+	struct btrfs_dump_send_args *r = user;
+	int ret;
+
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path, "chmod", "mode=%llo", mode);
+	} else {
+		ret = PRINT_DUMP(user, path, "chmod", "\"mode\": \"%llo\"", mode);
+	}
+	return ret;
  }

  static int print_chown(const char *path, u64 uid, u64 gid, void *user)
  {
-	return PRINT_DUMP(user, path, "chown", "gid=%llu uid=%llu", gid, uid);
+	struct btrfs_dump_send_args *r = user;
+	int ret;
+
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path, "chown", "gid=%llu uid=%llu",
+			  gid, uid);
+	} else {
+		ret = PRINT_DUMP(user, path, "chown",
+			  "\"gid\": %llu, \"uid\": %llu",
+			  gid, uid);
+	}
+	return ret;
  }

  static int sprintf_timespec(struct timespec *ts, char *dest, int max_size)
@@ -297,6 +437,8 @@ static int print_utimes(const char *path, struct timespec *at,
  			struct timespec *mt, struct timespec *ct,
  			void *user)
  {
+	struct btrfs_dump_send_args *r = user;
+	int ret;
  	char at_str[TIME_STRING_MAX];
  	char mt_str[TIME_STRING_MAX];
  	char ct_str[TIME_STRING_MAX];
@@ -305,15 +447,33 @@ static int print_utimes(const char *path, struct timespec *at,
  	    sprintf_timespec(mt, mt_str, TIME_STRING_MAX - 1) < 0 ||
  	    sprintf_timespec(ct, ct_str, TIME_STRING_MAX - 1) < 0)
  		return -EINVAL;
-	return PRINT_DUMP(user, path, "utimes", "atime=%s mtime=%s ctime=%s",
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path,
+			  "utimes", "atime=%s mtime=%s ctime=%s",
+			  at_str, mt_str, ct_str);
+	} else {
+		ret = PRINT_DUMP(user, path, "utimes",
+			  "\"atime\": \"%s\", \"mtime\": \"%s\", " \
+			    "\"ctime\": \"%s\"",
  			  at_str, mt_str, ct_str);
+	}
+	return ret;
  }

  static int print_update_extent(const char *path, u64 offset, u64 len,
  			       void *user)
  {
-	return PRINT_DUMP(user, path, "update_extent", "offset=%llu len=%llu",
-			  offset, len);
+	struct btrfs_dump_send_args *r = user;
+	int ret;
+
+	if (!r->json) {
+		ret = PRINT_DUMP(user, path, "update_extent",
+			   "offset=%llu len=%llu", offset, len);
+	} else {
+		ret = PRINT_DUMP(user, path, "update_extent",
+			   "\"offset\": %llu, \"len\": %llu", offset, len);
+	}
+	return ret;
  }

  struct btrfs_send_ops btrfs_print_send_ops = {
diff --git a/cmds/receive-dump.h b/cmds/receive-dump.h
index 06a61085..d62462d0 100644
--- a/cmds/receive-dump.h
+++ b/cmds/receive-dump.h
@@ -22,6 +22,7 @@
  struct btrfs_dump_send_args {
  	char full_subvol_path[PATH_MAX];
  	char root_path[PATH_MAX];
+	int json;
  };

  extern struct btrfs_send_ops btrfs_print_send_ops;
diff --git a/cmds/receive.c b/cmds/receive.c
index 2aaba3ff..e977e9db 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1244,6 +1244,8 @@ static const char * const cmd_receive_usage[] = {
  	"                 this file system is mounted.",
  	"--dump           dump stream metadata, one line per operation,",
  	"                 does not require the MOUNT parameter",
+	"--dump-json      dump stream metadata in JSON format,",
+	"                 does not require the MOUNT parameter",
  	"-v               deprecated, alias for global -v option",
  	HELPINFO_INSERT_GLOBALS,
  	HELPINFO_INSERT_VERBOSE,
@@ -1260,6 +1262,7 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
  	int receive_fd = fileno(stdin);
  	u64 max_errors = 1;
  	int dump = 0;
+	int dump_json = 0;
  	int ret = 0;

  	memset(&rctx, 0, sizeof(rctx));
@@ -1285,11 +1288,13 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
  	optind = 0;
  	while (1) {
  		int c;
-		enum { GETOPT_VAL_DUMP = 257 };
+		enum { GETOPT_VAL_DUMP = 257,
+			GETOPT_VAL_DUMP_JSON = 258 };
  		static const struct option long_opts[] = {
  			{ "max-errors", required_argument, NULL, 'E' },
  			{ "chroot", no_argument, NULL, 'C' },
  			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
+			{ "dump-json", no_argument, NULL, GETOPT_VAL_DUMP_JSON },
  			{ "quiet", no_argument, NULL, 'q' },
  			{ NULL, 0, NULL, 0 }
  		};
@@ -1333,6 +1338,10 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
  		case GETOPT_VAL_DUMP:
  			dump = 1;
  			break;
+		case GETOPT_VAL_DUMP_JSON:
+			dump = 1;
+			dump_json = 1;
+			break;
  		default:
  			usage_unknown_option(cmd, argv);
  		}
@@ -1360,12 +1369,21 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
  		dump_args.root_path[1] = '\0';
  		dump_args.full_subvol_path[0] = '.';
  		dump_args.full_subvol_path[1] = '\0';
+		dump_args.json = dump_json;
+		if (dump_json) {
+			putchar('[');
+			putchar('\n');
+		}
  		ret = btrfs_read_and_process_send_stream(receive_fd,
  			&btrfs_print_send_ops, &dump_args, 0, max_errors);
  		if (ret < 0) {
  			errno = -ret;
  			error("failed to dump the send stream: %m");
  		}
+		if (dump_json) {
+			//Add an empty record so there isn't a trailing ,
+			printf(" {}\n]");
+		}
  	} else {
  		ret = do_receive(&rctx, tomnt, realmnt, receive_fd, max_errors);
  	}
