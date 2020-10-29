Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF0D29F8FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJ2XSO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:18:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37337 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgJ2XSN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:18:13 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EB545C0108;
        Thu, 29 Oct 2020 19:18:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Oct 2020 19:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=AXuYrhu3YPP81
        ZrepInzGdwzWKZJiZkCsNS+VW9ucCA=; b=H66bcqMqwdW4YHUZY6mLdVT/ZtoIf
        a7Jeyh7z8hP2lsG0EKHv4rl8uqZ5MNqZgvu3j/lLl8CzXPsO0MEndKufhs+K2I+t
        zhuANNYhbE5Tjbra3yT2z32wfFOfwm3uNGG4fMgyT+9VuRupTTMTRlzUw5afKDOM
        c4AdqjpNLrnQDXIxVBQ89NAKacN/bfXQRgatzAJ0Mt4C/mgmNmUyv7A9wZe3Gy/P
        PXk7lxDLD8thbmQ4X3z0dPMiQguODjYKl2WU50XJqBncWayKSAHoemdYpWMI0PcS
        9/vOm4l2X97rehrH0x75OTFDESLOxgqiJlfUhr23QaI+vNMoa/rvLMXAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=AXuYrhu3YPP81ZrepInzGdwzWKZJiZkCsNS+VW9ucCA=; b=XfXbS9i8
        V6fmQ+0OrhI8VeEPtNRNFtR9V4Ytsi2pY1VrEzLCXerRR3nCn+Yp3I6uFeRrGDS8
        ep6aO4DbJp1jIzL7MO5OQ4qJHhmaSujNSO5h3zVHttcSu/i4HzM0fEtci/SNGzeg
        Tso+IlvpKAPlN2hiRBNqfQHcMYTvAABn2cSE6OC7oB/2srUlZ+Q35H1reKLRwXQi
        WjIVSUOggPhvk5f8YAV98xwmDEENDhC6uxqRLMJDueGk8zdXh4gMfuQbLskWfZLg
        N+B8x8GUfum45x4YTg6MTL728oxYoU2fnmWWxPBRVbGNMnb2TKsM+IjNac3PwkOe
        BWcvoNeOSjsUxg==
X-ME-Sender: <xms:tE2bX_3IsrgR9CtTmK1B7M7esdN5iEAvkjk2jremxnLYFYnZWC21UQ>
    <xme:tE2bX-H95DsFVsjvmyGTMA8HsxGAviGsIKqymVGYTCIRHgYnfFkuIYLy4TCPjpjiV
    eoz4SHERyIE9cNOsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfekudelkefhteevhfeggf
    dvgeefjeefgfeuvddutdfhgffghfehtdeuueetfeeinecukfhppeduieefrdduudegrddu
    fedvrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:tE2bX_6WZF1MlA_xFiWcBq54C5YGE_AFnegzAsZ6Si60gmdaDsKavg>
    <xmx:tE2bX03qh95kp7RLE6gOpSBavB2ay1a8Dxq9yfaFPpDPGJWyJJB2-A>
    <xmx:tE2bXyG1n900WHwzq6eUAYmvFfLw-N9um9QOPDyntLU5mUX0JaSXVw>
    <xmx:tE2bX0MSg-UGeSDq_HX6Os-Kit5USxLOxi-PEubW5PwzFi6chB39yw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD80C3064674;
        Thu, 29 Oct 2020 19:18:11 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs-progs: rescue: Update docs with create-control-device
Date:   Thu, 29 Oct 2020 16:17:38 -0700
Message-Id: <41ce291ac76b461c891ae64fbe18dcbb723178ef.1604013169.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604013169.git.dxu@dxuuu.xyz>
References: <cover.1604013169.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit updates the documentation for the new `btrfs rescue
create-control-device` subcommand.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 Documentation/btrfs-man5.asciidoc   | 8 +++++++-
 Documentation/btrfs-rescue.asciidoc | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index 65352009..082599c1 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -898,12 +898,18 @@ filesystem module:
 * get the supported features (can be also found under '/sys/fs/btrfs/features')
 
 The device is usually created by a system device node manager (eg. udev), but
-can be created manually:
+can be created manually with:
 
 --------------------
 # mknod --mode=600 c 10 234 /dev/btrfs-control
 --------------------
 
+or with:
+
+--------------------
+# btrfs rescue create-control-device
+--------------------
+
 The control device is not strictly required but the device scanning will not
 work and a workaround would need to be used to mount a multi-device filesystem.
 The mount option 'device' can trigger the device scanning during mount.
diff --git a/Documentation/btrfs-rescue.asciidoc b/Documentation/btrfs-rescue.asciidoc
index af544372..db40ce64 100644
--- a/Documentation/btrfs-rescue.asciidoc
+++ b/Documentation/btrfs-rescue.asciidoc
@@ -93,6 +93,11 @@ the log and the filesystem may be mounted normally again. The keywords to look
 for are 'open_ctree' which says that it's during mount and function names
 that contain 'replay', 'recover' or 'log_tree'.
 
+*create-control-device* ::
+Creates /dev/btrfs-control control device
++
+This command is for convenience when *mknod* is not installed on a system.
+
 EXIT STATUS
 -----------
 *btrfs rescue* returns a zero exit status if it succeeds. Non zero is
-- 
2.26.2

