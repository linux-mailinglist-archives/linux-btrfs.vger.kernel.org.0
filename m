Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76751631983
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 06:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKUFgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 00:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUFgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 00:36:47 -0500
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F16F1FCC2
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 21:36:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669009000; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FoBNZNTLlIRmmZL68jG8T/ZHNdjPX7BNsr1cNrP7+zH2v7r5zLsuIbIGOUIQ4OOCgJ9vs3vNScFnq4paenIARgHcQh9w8b0b+0SoiWmYJ9B2h6lK7zhLPhIAtx8wHqmVrTDtVMgAqyMg/Kc8ixclAqxvjyWn+QOHc4K+5aJhwls=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669009000; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=N6wa9buOlD+5p2dDoIShIDjlSEhtONawuhm6JQsKXts=; 
        b=HCL9XjVJQ9tlCuhK66BLpwl2nn6Q44crwrNUnF5hNVJ8sSnuLDNkGwWVzfUI+k2bfTc+RjXnJ0Bkc2TQyFu91w687f5m2pyCV/xSSetTqLiKRZGqd/m7TkA4+f32PcO0MVv6eaxwJ1PgykSAAOCb7NzNgtTTsKuLeZraz6wC4Nc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=J1s8/n9KFi6a1CdOuW05fxhtGG13bXfukCizClmlvL1qMfQsFopOk8k4I07wupySKdkB5qT84ugk
    8I9mmpSiZTyNXu63KcQUBJf8xcxo+qHwP32J2eAcG8TTWawHStIe  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669009000;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=N6wa9buOlD+5p2dDoIShIDjlSEhtONawuhm6JQsKXts=;
        b=I1X60gX+C4pHgvEFNxhoypyDJYIQrmbRM8w6vUKle6oFOQrDjFwVXnpTQGEFiLyX
        INth7tQSaXXrl6CM3KP9SAzl7dgK5C/VjCvQN6nXWbGwcVL+Y9lj6vN4fbWtWDJ/ZUu
        64QCzsGKrRfvDqiOdgtD/UsHhot9W8Qxg3GPhfdI=
Received: from localhost.localdomain (58.247.201.53 [58.247.201.53]) by mx.zohomail.com
        with SMTPS id 1669008999287746.9750048348268; Sun, 20 Nov 2022 21:36:39 -0800 (PST)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        sunzhipeng.scsmile@bytedance.com, strongbox8@zoho.com
Subject: [PATCH v1] btrfs-progs:Support send and receive to remote host
Date:   Mon, 21 Nov 2022 13:34:07 +0800
Message-Id: <20221121053407.1810-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Support send and receive through TCP

start server:
        btrfs server start

stop server:
        btrfs server stop

send:
        btrfs send --remote <ip address>:<pathname> <snapshot>

receive:
        btrfs receive --remote <ip address>:<pathname> <snapshot>

Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
---
 Makefile            |   2 +-
 btrfs.c             |   1 +
 cmds/commands.h     |   1 +
 cmds/receive.c      |  21 ++-
 cmds/send.c         |  22 +++-
 cmds/server.c       | 311 ++++++++++++++++++++++++++++++++++++++++++++
 common/send-utils.h |   6 +
 7 files changed, 361 insertions(+), 3 deletions(-)
 create mode 100644 cmds/server.c

diff --git a/Makefile b/Makefile
index c74a2ea9..33798e1d 100644
--- a/Makefile
+++ b/Makefile
@@ -208,7 +208,7 @@ cmds_objects = cmds/subvolume.o cmds/subvolume-list.o \
 	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
 	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o \
-	       check/clear-cache.o
+	       check/clear-cache.o cmds/server.o
 
 libbtrfs_objects = \
 		kernel-lib/rbtree.o	\
diff --git a/btrfs.c b/btrfs.c
index a1db7109..28bf6c00 100644
--- a/btrfs.c
+++ b/btrfs.c
@@ -353,6 +353,7 @@ static const struct cmd_group btrfs_cmd_group = {
 		/* Help and version stay last */
 		&cmd_struct_help,
 		&cmd_struct_version,
+		&cmd_struct_server,
 		NULL
 	},
 };
diff --git a/cmds/commands.h b/cmds/commands.h
index 42291a35..27828588 100644
--- a/cmds/commands.h
+++ b/cmds/commands.h
@@ -150,5 +150,6 @@ DECLARE_COMMAND(qgroup);
 DECLARE_COMMAND(replace);
 DECLARE_COMMAND(restore);
 DECLARE_COMMAND(rescue);
+DECLARE_COMMAND(server);
 
 #endif
diff --git a/cmds/receive.c b/cmds/receive.c
index af3138d5..11910ade 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1638,6 +1638,7 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	char *tomnt = NULL;
 	char fromfile[PATH_MAX];
+	char fromnet[PATH_MAX];
 	char realmnt[PATH_MAX];
 	struct btrfs_receive rctx;
 	int receive_fd = fileno(stdin);
@@ -1678,10 +1679,11 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
 			{ "quiet", no_argument, NULL, 'q' },
 			{ "force-decompress", no_argument, NULL, GETOPT_VAL_FORCE_DECOMPRESS },
+			{ "remote", required_argument, NULL, 'r'},
 			{ NULL, 0, NULL, 0 }
 		};
 
-		c = getopt_long(argc, argv, "Cevqf:m:E:", long_opts, NULL);
+		c = getopt_long(argc, argv, "Cevqf:m:E:n:r:", long_opts, NULL);
 		if (c < 0)
 			break;
 
@@ -1717,6 +1719,15 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 				goto out;
 			}
 			break;
+		case 'r':
+			if (arg_copy_path(fromnet, optarg, sizeof(fromnet))) {
+				error("input file location too long (%zu)",
+					strlen(optarg));
+				ret = 1;
+				goto out;
+			}
+			break;
+
 		case GETOPT_VAL_DUMP:
 			dump = true;
 			break;
@@ -1743,6 +1754,14 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 	}
 
+	if (fromnet[0]) {
+		receive_fd = setup_connection(fromnet, RECEIVE);
+		if (receive_fd < 0) {
+			error("cannot setup connection %s", fromnet);
+			goto out;
+		}
+	}
+
 	if (dump) {
 		struct btrfs_dump_send_args dump_args;
 
diff --git a/cmds/send.c b/cmds/send.c
index 41658899..3dc4dcb8 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -18,6 +18,9 @@
 
 #include "kerncompat.h"
 #include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <pthread.h>
@@ -464,6 +467,7 @@ static u32 get_sysfs_proto_supported(void)
 	return version;
 }
 
+
 static const char * const cmd_send_usage[] = {
 	"btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]",
 	"Send the subvolume(s) to stdout.",
@@ -510,6 +514,7 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	char *subvol = NULL;
 	int ret;
 	char outname[PATH_MAX];
+	char remotename[PATH_MAX];
 	struct btrfs_send send;
 	u32 i;
 	char *mount_root = NULL;
@@ -520,11 +525,13 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	bool new_end_cmd_semantic = false;
 	u64 send_flags = 0;
 	u64 proto = 0;
+	int sockfd;
 
 	memset(&send, 0, sizeof(send));
 	send.dump_fd = fileno(stdout);
 	send.proto = 1;
 	outname[0] = 0;
+	remotename[0] = 0;
 
 	/*
 	 * For send, verbose default is 1 (insteasd of 0) for historical reasons,
@@ -550,9 +557,10 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 			{ "no-data", no_argument, NULL, GETOPT_VAL_SEND_NO_DATA },
 			{ "proto", required_argument, NULL, GETOPT_VAL_PROTO },
 			{ "compressed-data", no_argument, NULL, GETOPT_VAL_COMPRESSED_DATA },
+			{ "remote", required_argument, NULL, 'r' },
 			{ NULL, 0, NULL, 0 }
 		};
-		int c = getopt_long(argc, argv, "vqec:f:i:p:", long_options, NULL);
+		int c = getopt_long(argc, argv, "vqec:f:i:p:r:", long_options, NULL);
 
 		if (c < 0)
 			break;
@@ -631,6 +639,13 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
 			full_send = false;
 			break;
+		case 'r':
+			if (arg_copy_path(remotename, optarg, sizeof(remotename))) {
+				error("remote file path too long (%zu)", strlen(optarg));
+				ret = 1;
+				goto out;
+			}
+			break;
 		case 'i':
 			error("option -i was removed, use -c instead");
 			ret = 1;
@@ -680,6 +695,11 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 	}
 
+	if (remotename[0]) {
+		sockfd = setup_connection(remotename, SEND);
+		send.dump_fd = sockfd;
+	}
+
 	if (isatty(send.dump_fd)) {
 		error(
 	    "not dumping send stream into a terminal, redirect it into a file");
diff --git a/cmds/server.c b/cmds/server.c
new file mode 100644
index 00000000..e9031c61
--- /dev/null
+++ b/cmds/server.c
@@ -0,0 +1,311 @@
+#include "kerncompat.h"
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <pthread.h>
+#include "kernel-lib/sizes.h"
+#include "cmds/commands.h"
+#include "common/string-utils.h"
+#include "common/path-utils.h"
+#include "common/send-utils.h"
+#include "common/messages.h"
+#include "kernel-shared/send.h"
+
+#define	BTRFSPORT	385
+#define	INITPAKLEN	(PATH_MAX + 3)
+
+static int create_socket(void)
+{
+	int sockfd;
+
+	sockfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd == -1) {
+		error("socket creation failed");
+		return errno;
+	}
+	return sockfd;
+}
+
+int setup_connection(char *remote, enum request req)
+{
+	char *pathname;
+	struct sockaddr_in servaddr;
+	int ret = 0;
+	int retcode = -1;
+	int pathlen;
+	int sockfd;
+	char buff[INITPAKLEN];
+
+	pathname = strchr(remote, ':');
+	if (pathname == NULL) {
+		error("illegal remote pathname");
+		ret = 1;
+		goto out;
+	}
+	*pathname = '\0';
+	pathname += 1;
+
+	pathlen = strlen(pathname);
+	buff[0] = req;
+	buff[1] = pathlen;
+	memcpy(&buff[2], pathname, pathlen);
+	buff[pathlen + 2] = '\0';
+
+	sockfd = create_socket();
+	if (sockfd == -1)
+		goto out;
+
+	servaddr.sin_family = AF_INET;
+	servaddr.sin_addr.s_addr = inet_addr(remote);
+	servaddr.sin_port = htons(BTRFSPORT);
+
+	if (connect(sockfd, (struct sockaddr *)&servaddr,
+		    sizeof(servaddr)) != 0) {
+		error("connection failed");
+		ret = errno;
+		goto out;
+	}
+
+	ret = write(sockfd, buff, INITPAKLEN);
+	if (ret != INITPAKLEN) {
+		error("write failed");
+		ret = errno;
+		goto out;
+	}
+
+	if (req == STOP) {
+		error("illegal request");
+		return -1;
+	}
+
+	ret = read(sockfd, &retcode, sizeof(int));
+	if (ret != sizeof(int)) {
+		error("read failed");
+		ret = errno;
+		goto out;
+	}
+
+	if (retcode == -1) {
+		error("server open failed");
+		ret = retcode;
+		goto out;
+	}
+	return sockfd;
+out:
+	return ret;
+}
+
+struct req_info {
+	enum request req;
+	int pathlen;
+	int filefd;
+	int connfd;
+};
+
+static void *snapsave_func(void *arg)
+{
+	int len;
+	struct req_info *ri = (struct req_info *) arg;
+	int ret;
+	int buffsize = BTRFS_SEND_BUF_SIZE_V1;
+	char tmpbuff[BTRFS_SEND_BUF_SIZE_V1];
+
+	switch (ri->req) {
+	case SEND:
+		while ((len = read(ri->connfd, tmpbuff, buffsize))) {
+			ret = write(ri->filefd, tmpbuff, len);
+			if (ret == -1) {
+				error("write failed");
+				exit(-1);
+			}
+		}
+		break;
+	case RECEIVE:
+		while ((len = read(ri->filefd, tmpbuff, buffsize))) {
+			ret = write(ri->connfd, tmpbuff, len);
+			if (ret == -1) {
+				perror("write failed");
+				exit(-1);
+			}
+		}
+		break;
+	default:
+		error("illegal request");
+		exit(-1);
+	}
+	close(ri->connfd);
+	free(ri);
+	return NULL;
+}
+
+static struct req_info *handle_request(int connfd)
+{
+	int tmpfd;
+	int ret;
+	char outname[PATH_MAX];
+	char buff[INITPAKLEN];
+	int flags;
+	struct req_info *ri;
+
+	ri = malloc(sizeof(*ri));
+	if (!ri) {
+		error("malloc failed");
+		exit(-1);
+	}
+
+	ret = read(connfd, buff, INITPAKLEN);
+	if (ret != INITPAKLEN) {
+		error("read failed");
+		exit(-1);
+	}
+
+	ri->req = (enum request) buff[0];
+	ri->pathlen = buff[1];
+	if (ri->pathlen < 0) {
+		error("illegal path length");
+		exit(-1);
+	}
+
+	memcpy(outname, &buff[2], ri->pathlen);
+	switch (ri->req) {
+	case SEND:
+		flags = O_WRONLY | O_TRUNC;
+		tmpfd = open(outname, flags);
+		if (tmpfd < 0) {
+			if (errno == ENOENT)
+				tmpfd = open(outname,
+						O_CREAT | flags, 0600);
+		}
+		break;
+	case RECEIVE:
+		flags = O_RDONLY;
+		tmpfd = open(outname, flags);
+		if (tmpfd < 0) {
+			error("open failed");
+			exit(-1);
+		}
+		break;
+	case STOP:
+		exit(1);
+	}
+
+	ri->filefd = tmpfd;
+	ret = write(connfd, &tmpfd, sizeof(int));
+	if (ret < 0) {
+		error("write failed");
+		exit(-1);
+	}
+	ri->connfd = connfd;
+	return ri;
+}
+
+static int btrfs_server(void)
+{
+	int ret;
+	socklen_t addr_len;
+	int connfd;
+	int sockfd;
+	pthread_t thread_id;
+	struct sockaddr_in servaddr;
+	struct sockaddr_in cli;
+	struct req_info *ri;
+
+	sockfd = create_socket();
+	if (sockfd == -1)
+		goto out;
+
+	servaddr.sin_family = AF_INET;
+	servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
+	servaddr.sin_port = htons(BTRFSPORT);
+
+	ret = bind(sockfd, (struct sockaddr *) &servaddr,
+			sizeof(servaddr));
+	if (ret) {
+		error("socket bind failed\n");
+		ret = errno;
+		goto out;
+	}
+
+	if ((listen(sockfd, 5)) != 0) {
+		error("listen failed\n");
+		ret = errno;
+		goto out;
+	}
+
+	addr_len = sizeof(cli);
+
+	while (true) {
+		connfd = accept(sockfd, (struct sockaddr *) &cli,
+				&addr_len);
+		if (connfd < 0) {
+			error("server accept failed");
+			ret = errno;
+			goto out;
+		}
+		ri = handle_request(connfd);
+		ret = pthread_create(&thread_id, NULL, snapsave_func, (void *) ri);
+		if (ret != 0) {
+			error("pthread create failed:%d\n", ret);
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static const char * const server_cmd_group_usage[] = {
+	"btrfs server <command>",
+	NULL
+};
+
+static const char * const cmd_server_start_usage[] = {
+	"btrfs server start",
+	NULL
+};
+
+static int cmd_server_start(const struct cmd_struct *cmd,
+			    int argc, char **argv)
+{
+	int ret;
+
+	ret = daemon(1, 0);
+	if (ret) {
+		error("daemon errno:%d\n", errno);
+		exit(-1);
+	}
+	btrfs_server();
+	return 0;
+}
+static DEFINE_SIMPLE_COMMAND(server_start, "start");
+
+static const char * const cmd_server_stop_usage[] = {
+	"btrfs server stop",
+	NULL
+};
+
+static int cmd_server_stop(const struct cmd_struct *cmd,
+			   int argc, char **argv)
+{
+	char dummy[16];
+	arg_copy_path(dummy, "127.0.0.1:dummy", 16);
+	setup_connection(dummy, STOP);
+	return 0;
+}
+static DEFINE_SIMPLE_COMMAND(server_stop, "stop");
+
+static const char server_cmd_group_info[] =
+"save and restore snapshot from remote";
+
+static const struct cmd_group server_cmd_group = {
+	server_cmd_group_usage, server_cmd_group_info, {
+		&cmd_struct_server_start,
+		&cmd_struct_server_stop,
+		NULL
+	}
+};
+
+DEFINE_GROUP_COMMAND_TOKEN(server);
diff --git a/common/send-utils.h b/common/send-utils.h
index 7bff81a1..124d668b 100644
--- a/common/send-utils.h
+++ b/common/send-utils.h
@@ -55,4 +55,10 @@ struct subvol_info *subvol_uuid_search(int mnt_fd,
 
 int btrfs_subvolid_resolve(int fd, char *path, size_t path_len, u64 subvol_id);
 
+enum request {
+	SEND = 1,
+	RECEIVE,
+	STOP,
+};
+int setup_connection(char *remote, enum request req);
 #endif
-- 
2.25.1

