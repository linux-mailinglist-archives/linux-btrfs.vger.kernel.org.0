Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2698D585661
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 23:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiG2VJA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 17:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2VI7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 17:08:59 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D36789EBA
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 14:08:56 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x11so4192960qts.13
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXnpDbbO09+Jqg/AAvQbaaywk5n6kaPnff1uEwWdVlE=;
        b=Z+E8pjypv6BZhp4/GqKU6Q1INbiJ7WVw2nr6sn8z8QvmZAan9dUd532JLZYkrgUEQc
         PntFB+ISomUP1tvEsXEJUJ9WSrAf7EsdqZa1AiBvQaI0tiJsGvBeab+NAqBsnKFXEtNP
         UB538sSMSRQGQZumjXQ2Qq5nh3ekNWHJYkejJUufRXk0P2/6enpExWnt+sU3z+jlT+F3
         MtCpfWbBHFjdrq/oKWVS4rn3aWPHd3b5s1zMCXGE5JsIX2ag5riwxy4WV+OVPwsVJ2Jg
         nOfDVh/83KgpHyQ/q6luv4CqIy4etI/K3cGer3Sn3TmtrB+yYB7k7cYxbiEAcN2VfRsF
         S9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXnpDbbO09+Jqg/AAvQbaaywk5n6kaPnff1uEwWdVlE=;
        b=2uWF/Jq/FVknfQFYpC1FLkYWB31FHQAbo2Mb2SWYcBWpcTk7aRer7RUmRjBlvaUAfR
         4Og0v0KGUZ16SQHNW5X1qhvnGCnvG1BLJpB9W+NDZNJrPQFDsrr8ok70oqcR7rWBwGvI
         H4dRtqBF05NEBje7NU+PQ8MAO56mR4RT5HQMLXBL4b5GLcuMirkjE+mBg2o7LiH1CIov
         0ZOSZgWgJSSWe2QRgdRKZlf1cgjAhkHwto9OXAIy7GEOHubc3bUg4rRz1e4FXlMt6tw/
         PvHqmMEchJSRiYblgc4qMapCFJqe3E4+Mi5MlObaFVc35DChlkGzAOwxfrYIOnu3aEpK
         IY/Q==
X-Gm-Message-State: AJIora9K4tiAWfpuRKsdmFB1JkLUZy2MVN4pbKCD/id+4NJgXYAWSvN1
        epQo2WQkKn22mAoJe4R03FtvJCw9iLX8YvHH
X-Google-Smtp-Source: AGRyM1u2WKlZAFxqGyJVM7EyVMRQ3j5eZ4XhMAQAQH4QdxesbDkjDySzchgSlZ+iv/1TlK3Ec3QFVg==
X-Received: by 2002:ac8:574a:0:b0:31f:fb8:7827 with SMTP id 10-20020ac8574a000000b0031f0fb87827mr5200156qtx.383.1659128935217;
        Fri, 29 Jul 2022 14:08:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v19-20020a05622a145300b0031ef6a420d6sm2855147qtx.35.2022.07.29.14.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 14:08:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: check for invalid free space tree entries
Date:   Fri, 29 Jul 2022 17:08:53 -0400
Message-Id: <e3fa3936cd8b01a05390d364a2cf41ca6c3f7834.1659128926.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing some changes to how we reclaim block groups I started
hitting failures with my TEST_DEV.  This occurred because I had a bug
and failed to properly remove a block groups free space tree entries.
However this wasn't caught in testing when it happened because
btrfs check only checks that the free space cache for the existing block
groups is valid, it doesn't check for free space entries that don't have
a corresponding block group.

Fix this by checking for free space entries that don't have a
corresponding block group.  Additionally add a test image to validate
this fix.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c                                  |  79 ++++++++++++++++++
 .../corrupt-free-space-tree.img.xz            | Bin 0 -> 1368 bytes
 2 files changed, 79 insertions(+)
 create mode 100644 tests/fsck-tests/058-bad-free-space-tree-entry/corrupt-free-space-tree.img.xz

diff --git a/check/main.c b/check/main.c
index 4f7ab8b2..fb119bfe 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5729,6 +5729,83 @@ static int verify_space_cache(struct btrfs_root *root,
 	return ret;
 }
 
+static int check_free_space_tree(struct btrfs_root *root)
+{
+	struct btrfs_key key = {};
+	struct btrfs_path *path;
+	int ret = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	while (1) {
+		struct btrfs_block_group *bg;
+		u64 cur_start = key.objectid;
+
+		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		if (ret < 0)
+			goto out;
+
+		/*
+		 * We should be landing on an item, so if we're above the
+		 * nritems we know we hit the end of the tree.
+		 */
+		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0]))
+			break;
+
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+		if (key.type != BTRFS_FREE_SPACE_INFO_KEY) {
+			fprintf(stderr, "Failed to find a space info key at %llu [%llu %u %llu]\n",
+				cur_start, key.objectid, key.type, key.offset);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		bg = btrfs_lookup_first_block_group(gfs_info, key.objectid);
+		if (!bg) {
+			fprintf(stderr, "We have a space info key for a block group that doesn't exist\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		btrfs_release_path(path);
+		key.objectid += key.offset;
+		key.offset = 0;
+	}
+	ret = 0;
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+static int check_free_space_trees(struct btrfs_root *root)
+{
+	struct btrfs_root *free_space_root;
+	struct rb_node *n;
+	struct btrfs_key key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	int ret = 0;
+
+	free_space_root = btrfs_global_root(gfs_info, &key);
+	while (1) {
+		ret = check_free_space_tree(free_space_root);
+		if (ret)
+			break;
+		n = rb_next(&root->rb_node);
+		if (!n)
+			break;
+		free_space_root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->root_key.objectid != BTRFS_FREE_SPACE_TREE_OBJECTID)
+			break;
+	}
+	return ret;
+}
+
 static int check_space_cache(struct btrfs_root *root)
 {
 	struct extent_io_tree used;
@@ -10121,6 +10198,8 @@ static int validate_free_space_cache(struct btrfs_root *root)
 	}
 
 	ret = check_space_cache(root);
+	if (!ret && btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE))
+		ret = check_free_space_trees(root);
 	if (ret && btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE) &&
 	    repair) {
 		ret = do_clear_free_space_cache(2);
diff --git a/tests/fsck-tests/058-bad-free-space-tree-entry/corrupt-free-space-tree.img.xz b/tests/fsck-tests/058-bad-free-space-tree-entry/corrupt-free-space-tree.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..93280b82749c87183c8222740f15f6abca3d9bbf
GIT binary patch
literal 1368
zcmV-e1*iJ`H+ooF000E$*0e?f03iVu0001VFXf}+Q~w1OT>wRyj;C3^v%$$4d1ocf
zjjaF1$3^@a-*Xj3r-#5<9#Wqg%5NYWtuFyaX3{;HIsTkK=A=aNB3|l5$%+=o8g1{`
z9>n_MeGBmNWMc2O8%=OwNuQkT%DC=u6%>3ias*)m2w2Vj{<X`j2OnKGMEZ%xR1cy`
zv?-{L(P2Vkw0p<|MXz$0(HMoM8$Cs<!9}Ebp|h0L_u(K6y=q5|H5~9~lfr>K%U40+
z_*HaH3>s3Be3<P8!YiHA`cw6c01&vER1Oyfl&3F9`o@wse1epc9c+bHS%moHfGbi0
za>G|qceZM^9=!MAA{x7B*DdZw`=MZbP>g&&UJ78w*_xFJ*ymY);<Mbk211PVqr9pY
z2$a*{$ddCoWl0v${~c<P0kv>=&F%~Em~&)LIgI!eG5|{o17mJxTHbL0LzMS}X7Rn(
z8aG+sA}om=lMvs%yH^30B*fHO+M3JW%myi2Q@oISpjzVQL->PHN#F;kkTDP9m3d&G
zATJRzI9%32{Q#bQRBPs+qO=%P(RJuP|KXmbBKz&TwxJq`c>bGV$H_w?rL#W~CBA&Y
zTVrF&)Lgdkg=t8HuJHV%5gY<|+kT6=fq0y7i5Dq~A`8gp{)hlOigUZY*~kzbW*nyy
zPy`p*ZYH)a7M@cM%W+<aS#c!NBv6M#k&B?|Gp>@{OMl<t$~kLNW5L+}or+3uMfZCa
zPdfQpi-M`W(}|V|bGaH}H$OWtV5FtcB!t8htp{EN<x2hz!>(-bc0W+2Ou$DqMhHg0
zAXXfJ)lD^OQ+ZsozgJ|ED^p@%Xk(nRRA=1*@@0`G!v_f=eu`$4g=+OcYHd?o<s{k<
zxnc&Y__V)N3e2C_ckEzS<C+G7Nmfx90n%C0*tw3Kx?CrF*A4nznbUo#(uhw;yi{b&
zUFA$8;MagqpNk9<F7lTE&f5YUW5zkYknyP}6_&g7maa>n#o^)Go`Vsk4wWALj%6xo
zaptcSD`V9YyHG^8)iRj!Joyn!>AZaZYq|%`TqWRNiYO4%%UH-fOt<QXMD?{|hGUbp
zrYY)<e8>}&<1eT_XhMooY9PF)hWGE81Aws&1!uWAsqM;Ila>-d{V}&$g0ds)zg&5W
zy@oE>Vku@9rAuL@*wgdz7LuW?v&?fv^VEo(ELFU8)sSplTO|-_Q>g)KAl2D8@Wv4Y
zy}hHu5?eK*DQHnJhNk1<@fb?xFkdSAlPxV;TKl{n;f9EkWjJt73KuO}-qG&G+*R)4
zhwOeTHj!?vZ|(K2a(js@blT`!xJhTI{G8PmIgngOpf5HKr4%f_C@7a5O$XsR>`ph3
zJz=xXUxXe6<DAbu*W&a8RFF;`p>>7gvsh$Ew3X_(ssfEfMDkER1cYqYxN3}-w)g0`
z`SCbd(vQevQ;+U<8TtQb{OE;fs!)YC&?A1H9|)Br;s1wxo&K&9?UjEYW|mKVQq6tH
zm(NruvFH7=%Q?*I)g6tb0-kV?<>qj-__Hc`D^QsGKI9`d+nL^1g*N?EU%c~9&I=R?
zBW6edh^W^U!u{1k%mq`Fcp#QU4}(<wxlpXBWvSX#&huX4Ijqe+-iDRro04Xy+{kR)
z(^+iDSztUr)`280d<1=uO{~1UM1%4>BZvQQ4zC#B;#@cKzqPk)OV4xGUgcG@RzDoN
zvL!%GwW?EsbyiH<;7;8+b{X<zmZ8HfcL|V@C=a>Xdph+>?Zp590000pn{%NX14{`2
a0kH~zs0jcD4TH0>#Ao{g000001X)^gHlHK_

literal 0
HcmV?d00001

-- 
2.26.3

