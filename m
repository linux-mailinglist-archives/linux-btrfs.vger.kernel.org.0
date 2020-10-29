Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2229F8FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgJ2XSN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:18:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33899 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgJ2XSM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:18:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BD3395C0127;
        Thu, 29 Oct 2020 19:18:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Oct 2020 19:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=vdqtJzroHoFHS
        9urMLXID6uPIJ1tiT0lVYNo6pN6cZk=; b=SJxS5EPThT5TzKtMNpQarMtpIqHy1
        6pcZSyeixl7yTwGeO0NbXAfZnyFga0AOYf744YyB6gbS1t0om0EtY7IZesj+vsnQ
        KDQ3Cy0HARJJZ+YllCKYQvB2n48B5X3ck5/Sem5RWMD9duSDxhk6DlLDiM0oBs+W
        Ic/5fTq8/Xu41l/qGJzKzLl1+nppJGItNKHjkMOCrhdlhMLPofPZ3IH6xnzg6Xwg
        4wOCDfH7S7dwuFB2Ug6DAigOrwXuXdDca6CRWBtwdP6FspRySK8JLmVjlZwnUEdA
        eUni+QFRr3h7SASVgBxjlt55sQvqCkI92a/ZxRoUp5dYGhGDqV+YZFAIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=vdqtJzroHoFHS9urMLXID6uPIJ1tiT0lVYNo6pN6cZk=; b=OMoBDDuR
        TTIFf9OLkIg9Ns9AkBQyFsb8BxrSIE79xx7wto1iG8w6kRaEuOurLEguEkp1Tc4o
        hok4OSaqmZ+5LFoDpdIotYMMWsJFY0/i5Kcv4+Y27uhfbbtwR9WhDN9gRfaSpw9N
        NkCW4RjsyWqHTtvmp29kGP0kdmY3Jy5GZga6E0150ngC9wzem+E/S4pS51c3WuUZ
        Dt+iA3BOafjqC6Mzs8rbwr/Ye6/wXcK6EQSUpT8Q63oa2THJJ+DCmbfUyfGKWq6M
        F+OLtMgITXKGOAa9edHcKegUQVeLQJZ6zh33iVeNaQfScJtRYLUcrTKG6ibt8wbC
        Cs/vOne3sHQ5fw==
X-ME-Sender: <xms:s02bXye6yfXTMS4WO-NDxp-R_m4Cft3cg7KCRVo7nLahYg5FBnKUNg>
    <xme:s02bX8NoDZocR4WywW1b1xtNWvyz9mtQBEXd6fOWb3YbD5vggZKLDKjyvWq-MIy5M
    aLdiRi6uMWxul19xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfekudelkefhteevhfeggf
    dvgeefjeefgfeuvddutdfhgffghfehtdeuueetfeeinecukfhppeduieefrdduudegrddu
    fedvrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:s02bXzgl-UgwBsF1JE3RyMvKGtUlBz-NJPxNMPNKyubsO9GOkZcVmw>
    <xmx:s02bX_-UCA4SsWTkE5fIw0fSUAyvON3gZX6WVFAaWotj9giBsUK2Cw>
    <xmx:s02bX-tO3GiA-DKn2iej48rnLszBMHZBANd_6McefNZSgOnJrScLPg>
    <xmx:s02bXzWh1yiRAImhO67GN0vP3TOWT7xOQXZulbg84JAWKDrFkc2Exg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id ECE3A3064684;
        Thu, 29 Oct 2020 19:18:10 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs-progs: bash: Update completion script with create-control-device
Date:   Thu, 29 Oct 2020 16:17:37 -0700
Message-Id: <8c48f71ff99c7e317524e3a189a3218e200d33c2.1604013169.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604013169.git.dxu@dxuuu.xyz>
References: <cover.1604013169.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The previous commit added a new subcommand so in this commit we update
the bash completion script.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 btrfs-completion | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btrfs-completion b/btrfs-completion
index 6ae57d1b..5bbd5378 100644
--- a/btrfs-completion
+++ b/btrfs-completion
@@ -28,7 +28,7 @@ _btrfs()
 	commands_balance='start pause cancel resume status'
 	commands_device='scan add delete remove ready stats usage'
 	commands_scrub='start cancel resume status'
-	commands_rescue='chunk-recover super-recover zero-log'
+	commands_rescue='chunk-recover super-recover zero-log create-control-device'
 	commands_inspect_internal='inode-resolve logical-resolve subvolid-resolve rootid min-dev-size dump-tree dump-super tree-stats'
 	commands_property='get set list'
 	commands_quota='enable disable rescan'
-- 
2.26.2

