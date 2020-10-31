Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A62A11DF
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Oct 2020 01:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgJaAPd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 20:15:33 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46055 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgJaAPc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 20:15:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CA0055C016D;
        Fri, 30 Oct 2020 20:15:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 30 Oct 2020 20:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=vEeu6DqivALoYGrJ8l3e05Tyj2
        ldDJlseUIPAT0pOGs=; b=SwrDu3flHjImqN8KLMNR2Dv0Djwk9GJt7N6SdnLnNb
        kR12kzBFFj3wla+hAiEKFnUTyILBifWOJMucrPf5vsSljwWheGZz6b33O68grvn6
        U3pM3WYC3SqYaXmlXQqSn8fBRPjcfSaOEAYjYzL42plyq7jCjQ/+pAKqN3LhTT76
        629O0SISOmIcwRHmTbk95OL0/Hhf4/o5UbupA4weTKGZQ5IPSysebqZ2SrutWTqZ
        h+wi1sAAg8MF+kTQTFOKLmSZl5+OaqFniCRjJUEurGidTKC7idgiVOdKPFS8ib+3
        tRLNJKkzDnmp3uvzx2hXwGG8yy2X4ItyAHPH54wnuTRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vEeu6DqivALoYGrJ8
        l3e05Tyj2ldDJlseUIPAT0pOGs=; b=eq4yTmvsbc+VBbMf7wCLErMZX/UL3pq4c
        O7y4J26u998hAG3eJYuC4v6vX3y9EvwW12MIKrhUny3CByfyreRCzT3MCj9AC+AI
        ra9+YMvGaCko1JQbMHIuepBd4UTQfKNW5WH79wj3PQprKQuENbC/ZAhUDm8VugL/
        zXBRasj8sxnpeUyfTqT/Wic3vbMRbHmPd56sgznRCjIpGq2zdudsEMIGZo+9+Fk8
        Ye2lzIa3SNGPqfe+yUTDlBx/wY9S/Jc+nEl42XGK9eubyGMY4dAaxqtEEf12Tthw
        5z4f3ZOTVQ4wLZDn1bo+kBnKksFj/mF67yEuF0wtFs1nqIZ0rN9pg==
X-ME-Sender: <xms:oaycX776hNqrlaleHORB4wvuZDq0mgxODjyYrF4c1cXXAMbAZfxzgQ>
    <xme:oaycXw6TA7dcekfI89lvPbqY62k3-9QnnlhIk6vU4k1eckJWlkc8I-jV86gqFX-hL
    0Qzt1-LqGd_-gXEGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeigddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieffgfelvdffiedtleejvdetfe
    efiedvfeehieevveejudeiiefgteeiveeiffffnecukfhppeduieefrdduudegrddufedv
    rdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepug
    iguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:oaycXyeJ7M5dyCdXzak9K1oXKpFjk8QXPk8DAxx8Sc9K6Ilq6uwtCg>
    <xmx:oaycX8LbxiSm4nRur2gWJ2UIRgkThec7YNw5RqpPZR_KxpbDTSYvaQ>
    <xmx:oaycX_KhN2HD_3boTBDwdGVl1I_0vm0e6FTvWelPgq8YB5J0IiPgvw>
    <xmx:oqycX1jdgJxynBtCLrsVOh0dZM2NcjK_YNe9nssrh4ZuA_MT_lkYpQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.6])
        by mail.messagingengine.com (Postfix) with ESMTPA id 352F83064610;
        Fri, 30 Oct 2020 20:15:29 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: Sort main help menu
Date:   Fri, 30 Oct 2020 17:15:20 -0700
Message-Id: <e54b68968ee84f69fac0aa58db8495b99c845a82.1604103293.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

`btrfs help` is quite long and requires scrolling. For someone
who has a vague idea of what a subcommand is called but not quite sure,
alphabetical listing can help them find what they're looking for faster.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 btrfs.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/btrfs.c b/btrfs.c
index 87d64f49..c40ddfa6 100644
--- a/btrfs.c
+++ b/btrfs.c
@@ -330,21 +330,24 @@ static void handle_special_globals(int shift, int argc, char **argv)
 
 static const struct cmd_group btrfs_cmd_group = {
 	btrfs_cmd_group_usage, btrfs_cmd_group_info, {
-		&cmd_struct_subvolume,
-		&cmd_struct_filesystem,
+		/* Keep subcommands alphabetically sorted */
 		&cmd_struct_balance,
-		&cmd_struct_device,
-		&cmd_struct_scrub,
 		&cmd_struct_check,
-		&cmd_struct_rescue,
-		&cmd_struct_restore,
+		&cmd_struct_device,
+		&cmd_struct_filesystem,
 		&cmd_struct_inspect,
 		&cmd_struct_property,
-		&cmd_struct_send,
-		&cmd_struct_receive,
-		&cmd_struct_quota,
 		&cmd_struct_qgroup,
+		&cmd_struct_quota,
+		&cmd_struct_receive,
 		&cmd_struct_replace,
+		&cmd_struct_rescue,
+		&cmd_struct_restore,
+		&cmd_struct_scrub,
+		&cmd_struct_send,
+		&cmd_struct_subvolume,
+
+		/* Help and version stay last */
 		&cmd_struct_help,
 		&cmd_struct_version,
 		NULL
-- 
2.26.2

