Return-Path: <linux-btrfs+bounces-406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D1D7FB4AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 09:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56981B21B54
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA43D2E3E5;
	Tue, 28 Nov 2023 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gntnZtNb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A982119B3
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 00:45:27 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD22E1F45A;
	Tue, 28 Nov 2023 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701161125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fsnj9nQVCMr9teYvnU6MwYoDAnHfCRRjzopxhWAukq0=;
	b=gntnZtNbUtZDx8g/duy07RREEABo2/KnQXBRMTb3na44PZ2lX4YPXnWZse8GdkjSX4rb0M
	7FA+A7kUxwwq6KUGcLgCAw1w9xwCCGRk0eVwPJTLHG7F+XDbL9r5gtk9+MCPq8y0OklEZ3
	ooyhQSss/dNmX4ieYYuMZ+RSrzofuOc=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 18544139FC;
	Tue, 28 Nov 2023 08:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CDptLaOoZWXSRAAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 28 Nov 2023 08:45:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: william.brown@suse.com
Subject: [PATCH 3/3] btrfs-progs: subvolume-list: output qgroup sizes for subvolumes
Date: Tue, 28 Nov 2023 19:14:53 +1030
Message-ID: <1ef88bdfed7ea8e0e05a3518d74921782213fd16.1701160698.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701160698.git.wqu@suse.com>
References: <cover.1701160698.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 7.85
X-Spamd-Result: default: False [7.85 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_SPAM_SHORT(2.35)[0.783];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:~];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

Inspired by ZFS `zpool list`, which would output the sizes of each
subvolume, we can do better for out "btrfs subvolume list" UI/UX.

This patch would introduce the auto-detection and auto-output using
qgroup sizes for subvolumes.

The output would look like this:

 # ./btrfs subv list -t /mnt/btrfs/
 ID	gen	top level	rfer	excl	path
 --	---	---------	----	----	----
 256	11	5		1064960	1064960	subvol1
 257	11	5		4210688	4210688	subvol2

Unfortunately there would be some pitfalls:

- No output for subvolume 5 (fs tree)
  As we do not output subvolume 5 (fs tree) at all, thus if the end user
  wants the size of fs tree, they would still be upset.

- If qgroup is not enabled, the sizes would be omitted
  This may lead to different outputs for different use cases and can
  lead to some confusion.

- Over simplified column name
  As a developer get too used to qgroup, I don't have any better names for
  the sizes right now.

- Table output can easily be screwed up by the larger sizes
  This requires some update to the table output to know the possible
  longest values to adjust.
  Which is definitely worthy some other patchsets to address.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-subvolume.rst |  12 ++-
 cmds/subvolume-list.c             | 140 +++++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
index eb116c4bdc95..8eaab5872d70 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -130,7 +130,7 @@ list [options] [-G [\+|-]<value>] [-C [+|-]<value>] [--sort=rootid,gen,ogen,path
 
         For every subvolume the following information is shown by default:
 
-        ID *ID* gen *generation* top level *parent_ID* path *path*
+        ID *ID* gen *generation* top level *parent_ID* [size (referenced) *rfer* size (exclusive) *excl*] path *path*
 
         where *ID* is subvolume's (root)id, *generation* is an internal counter which is
         updated every transaction, *parent_ID* is the same as the parent subvolume's id,
@@ -138,6 +138,11 @@ list [options] [-G [\+|-]<value>] [-C [+|-]<value>] [--sort=rootid,gen,ogen,path
         The subvolume's ID may be used by the subvolume set-default command,
         or at mount time via the *subvolid=* option.
 
+	The sizes of a subvolume will only be outputted if qgroup is enabled,
+	as that's the only way to get accurate size of a subvolume.
+	The referenced size is the total bytes of every extent referred by that subvolume.
+	While the exclusive size is total bytes that is exclusive to that subvolume.
+
         ``Options``
 
         Path filtering:
@@ -163,6 +168,11 @@ list [options] [-G [\+|-]<value>] [-C [+|-]<value>] [--sort=rootid,gen,ogen,path
         -q
                 print the parent UUID of the subvolume
                 (*parent* here means subvolume of which this subvolume is a snapshot).
+
+	-Q
+		always print the qgroup sizes of the subvolume
+		If qgroup is not enabled, a warning would be outputted and all
+		qgroup sizes would be zero.
         -R
                 print the UUID of the sent subvolume, where the subvolume is the result of a receive operation.
 
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index e05f7228b889..28826571ab97 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -66,6 +66,7 @@ static const char * const cmd_subvolume_list_usage[] = {
 	OPTLINE("-g", "print the generation of the subvolume"),
 	OPTLINE("-u", "print the uuid of subvolumes (and snapshots)"),
 	OPTLINE("-q", "print the parent uuid of the snapshots"),
+	OPTLINE("-Q", "always print the qgroup size of each subvolume (instead of auto detect)"),
 	OPTLINE("-R", "print the uuid of the received snapshots"),
 	"",
 	"Type filtering:",
@@ -131,6 +132,10 @@ struct root_attr {
 	/* creation time of this root in sec*/
 	time_t otime;
 
+	/* Qgroup accounting. */
+	u64 rfer;
+	u64 excl;
+
 	u8 uuid[BTRFS_UUID_SIZE];
 	u8 puuid[BTRFS_UUID_SIZE];
 	u8 ruuid[BTRFS_UUID_SIZE];
@@ -195,6 +200,8 @@ enum btrfs_list_column_enum {
 	BTRFS_LIST_PUUID,
 	BTRFS_LIST_RUUID,
 	BTRFS_LIST_UUID,
+	BTRFS_LIST_QGROUP_RFER,
+	BTRFS_LIST_QGROUP_EXCL,
 	BTRFS_LIST_PATH,
 	BTRFS_LIST_ALL,
 };
@@ -286,6 +293,16 @@ static struct {
 		.column_name	= "UUID",
 		.need_print	= 0,
 	},
+	{
+		.name		= "rfer",
+		.column_name	= "RFER",
+		.need_print	= 0,
+	},
+	{
+		.name		= "excl",
+		.column_name	= "EXCL",
+		.need_print	= 0,
+	},
 	{
 		.name		= "path",
 		.column_name	= "Path",
@@ -567,6 +584,10 @@ static void update_root_attr(struct root_attr *found,
 		found->ogen = new->root_offset;
 	if (new->otime)
 		found->otime = new->otime;
+	if (new->rfer)
+		found->rfer = new->rfer;
+	if (new->excl)
+		found->excl = new->excl;
 	if (new->uuid[0])
 		memcpy(&found->uuid, new->uuid, BTRFS_UUID_SIZE);
 	if (new->puuid[0])
@@ -574,6 +595,7 @@ static void update_root_attr(struct root_attr *found,
 	if (new->ruuid[0])
 		memcpy(&found->ruuid, new->ruuid, BTRFS_UUID_SIZE);
 
+
 }
 
 static int update_root(struct rb_root *root_lookup,
@@ -789,6 +811,88 @@ static int lookup_ino_path(int fd, struct root_info *ri)
 	return 0;
 }
 
+static int fill_qgroup_attrs(int fd, struct rb_root *root_lookup)
+{
+	struct btrfs_ioctl_search_args args = {
+		.key = {
+			.tree_id = BTRFS_QUOTA_TREE_OBJECTID,
+			.max_type = BTRFS_QGROUP_INFO_KEY,
+			.min_type = BTRFS_QGROUP_INFO_KEY,
+			.max_objectid = (u64)-1,
+			.max_offset = (u64)-1,
+			.max_transid = (u64)-1,
+			.nr_items = 4096,
+		},
+	};
+	struct btrfs_ioctl_search_key *sk = &args.key;
+	int ret;
+
+	while (1) {
+		unsigned long off = 0;
+
+		ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
+		if (ret < 0) {
+			if (errno == ENOENT)
+				ret = -ENOTTY;
+			else
+				ret = -errno;
+			goto out;
+		}
+		/* the ioctl returns the number of item it found in nr_items */
+		if (sk->nr_items == 0)
+			goto out;
+
+		for (int i = 0; i < sk->nr_items; i++) {
+			struct root_attr attr = { 0 };
+			struct btrfs_ioctl_search_header *sh;
+			struct btrfs_qgroup_info_item *info;
+			struct btrfs_key key;
+
+			sh = (struct btrfs_ioctl_search_header *)(args.buf + off);
+			off += sizeof(*sh);
+
+			key.objectid = btrfs_search_header_objectid(sh);
+			key.type = btrfs_search_header_type(sh);
+			key.offset = btrfs_search_header_offset(sh);
+
+			/* Skip unrealted items and higher level qgroups. */
+			if (key.type != BTRFS_QGROUP_INFO_KEY ||
+			    btrfs_qgroup_level(key.offset))
+				goto next;
+
+			info = (struct btrfs_qgroup_info_item *)(args.buf + off);
+
+			attr.root_id = key.offset;
+			attr.rfer = btrfs_stack_qgroup_info_rfer(info);
+			attr.excl = btrfs_stack_qgroup_info_excl(info);
+			ret = add_root(root_lookup, &attr);
+			if (ret < 0)
+				break;
+next:
+			off += btrfs_search_header_len(sh);
+
+			/*
+			 * record the mins in sk so we can make sure the
+			 * next search doesn't repeat this root
+			 */
+			sk->min_type = key.type;
+			sk->min_offset = key.offset;
+			sk->min_objectid = key.objectid;
+		}
+		sk->nr_items = 4096;
+		/*
+		 * this iteration is done, step forward one qgroup for the next
+		 * ioctl
+		 */
+		if (sk->min_offset < (u64)-1)
+			sk->min_offset++;
+		else
+			break;
+	}
+out:
+	return ret;
+}
+
 static int list_subvol_search(int fd, struct rb_root *root_lookup)
 {
 	int ret;
@@ -1157,6 +1261,12 @@ static void print_subvolume_column(struct root_info *subv,
 			uuid_unparse(attrs->ruuid, uuidparse);
 		pr_verbose(LOG_DEFAULT, "%-36s", uuidparse);
 		break;
+	case BTRFS_LIST_QGROUP_RFER:
+		pr_verbose(LOG_DEFAULT, "%llu", attrs->rfer);
+		break;
+	case BTRFS_LIST_QGROUP_EXCL:
+		pr_verbose(LOG_DEFAULT, "%llu", attrs->excl);
+		break;
 	case BTRFS_LIST_PATH:
 		BUG_ON(!attrs->full_path);
 		pr_verbose(LOG_DEFAULT, "%s", attrs->full_path);
@@ -1280,6 +1390,12 @@ static void print_subvol_json_key(struct format_ctx *fctx,
 	case BTRFS_LIST_UUID:
 		fmt_print(fctx, column_name, attrs->uuid);
 		break;
+	case BTRFS_LIST_QGROUP_RFER:
+		fmt_print(fctx, column_name, attrs->rfer);
+		break;
+	case BTRFS_LIST_QGROUP_EXCL:
+		fmt_print(fctx, column_name, attrs->excl);
+		break;
 	case BTRFS_LIST_PUUID:
 		fmt_print(fctx, column_name, attrs->puuid);
 		break;
@@ -1363,6 +1479,7 @@ static int btrfs_list_subvols(int fd, struct rb_root *root_lookup)
 {
 	int ret;
 	struct rb_node *n;
+	bool qgroup_enabled = false;
 
 	ret = list_subvol_search(fd, root_lookup);
 	if (ret) {
@@ -1370,6 +1487,17 @@ static int btrfs_list_subvols(int fd, struct rb_root *root_lookup)
 		return ret;
 	}
 
+	ret = fill_qgroup_attrs(fd, root_lookup);
+	/*
+	 * Qgroup is not enabled but the user is trying to output qgroup info
+	 * explicitly, give a warning at least.
+	 */
+	if (ret < 0 && (btrfs_list_columns[BTRFS_LIST_QGROUP_RFER].need_print ||
+			btrfs_list_columns[BTRFS_LIST_QGROUP_EXCL].need_print)) {
+		errno = -ret;
+		warning("qgroup output is not available: %m");
+	}
+
 	/*
 	 * now we have an rbtree full of root_info objects, but we need to fill
 	 * in their path names within the subvol that is referencing each one.
@@ -1379,11 +1507,17 @@ static int btrfs_list_subvols(int fd, struct rb_root *root_lookup)
 		struct root_info *entry;
 
 		entry = to_root_info(n);
+		if (entry->attrs.rfer && entry->attrs.excl)
+			qgroup_enabled = true;
 		ret = lookup_ino_path(fd, entry);
 		if (ret && ret != -ENOENT)
 			return ret;
 		n = rb_next(n);
 	}
+	if (qgroup_enabled) {
+		btrfs_list_setup_print_column(BTRFS_LIST_QGROUP_RFER);
+		btrfs_list_setup_print_column(BTRFS_LIST_QGROUP_EXCL);
+	}
 
 	return 0;
 }
@@ -1568,7 +1702,7 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 		};
 
 		c = getopt_long(argc, argv,
-				    "acdgopqsurRG:C:t", long_options, NULL);
+				    "acdgopqQsurRG:C:t", long_options, NULL);
 		if (c < 0)
 			break;
 
@@ -1609,6 +1743,10 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 		case 'q':
 			btrfs_list_setup_print_column(BTRFS_LIST_PUUID);
 			break;
+		case 'Q':
+			btrfs_list_setup_print_column(BTRFS_LIST_QGROUP_RFER);
+			btrfs_list_setup_print_column(BTRFS_LIST_QGROUP_EXCL);
+			break;
 		case 'R':
 			btrfs_list_setup_print_column(BTRFS_LIST_RUUID);
 			break;
-- 
2.42.1


