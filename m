Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F4374C0E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 01:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhEEXoi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 19:44:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44857 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhEEXoi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 May 2021 19:44:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 03FD45C0148;
        Wed,  5 May 2021 19:43:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 May 2021 19:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nHt1VmzYNgHhKVL92enzmuiy+ew
        +WnqKaWaZixc8THg=; b=PWw9CKsTcn+fiJu3gMSqQpeKJSBUGnUIMIDS1C6exLf
        DCljOd5EpFt6WtsnyuDCoU0IRyWVuoXd5zvkZQ74kEy45OhMSW0VO7OhCr2IfMVf
        cmChc4XOw9d6ZCS+mZL2BSbNudwHzTfrcGe6MFZ8U8A/sdtMsuX0q4LA7ZpmSfil
        I63RTIvMgBONEGeQEjlyD6PS2doDpnA25pihffkxZAxOuDiYqS1QyINLW/VtqK5i
        xt68VAAQzPIlRVGtQ7N5KsSZ52hzyC6EhKPGw0IPsPBrSOIkTHqmBCgghmb+8SLP
        +y1NTcPqZh+kCc/daLFWRHXh/oFeobNq7RaGr8k3yAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nHt1Vm
        zYNgHhKVL92enzmuiy+ew+WnqKaWaZixc8THg=; b=QwwVkYZFVoJNiO9xKAY6tq
        mpkOUOKENg2MM7CKG65wedwY5EDbpRAP4RFLLtrK4Ggt2135lrqkvuff2jpMMfhW
        AYr4g9bdOJu2sgJTGmowbxYiZ/sIjCjGky4/arL2ZV+rqv/vs4sEpHc1sXORv0zj
        OL1t3jCNwOSIa3rLYWlNIiKzhzKbk/bk9pxWwHaUV3B6E83Y+vaY4rde/xNVgznm
        01SnjTz8ETwpHq4voAlzv+jyLJnBIYdctJ6MeP9/6/nH2A9pLEj/n2FGLYEM30A0
        U33FPLatspl17pcwKyQe/1CO1LRBG0vFDoWEV0KzSxNsQ9SmLX46E/gWg7wqyOQw
        ==
X-ME-Sender: <xms:rC2TYGfKcPPjI-OyGCqzB55K4GaVTz1pePckXP9iK2Jnubl_oamfSQ>
    <xme:rC2TYAPUyC36QeTy_rCdPWo3UyjgtRGlVwZuOkmvlcQK_vbp_jffLwrbnIpr6Ui6Z
    sRzq2sV89ckLjDNX4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    eitedtieeuteeuleegieehgfduieejuefghedvhfdtffevuddvheehtefhueehnecuffho
    mhgrihhnpehgnhhurdhorhhgnecukfhppedvtdejrdehfedrvdehfedrjeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhr
    rdhioh
X-ME-Proxy: <xmx:rC2TYHhPIfHrWT5ernwARHsvKJU6hq_DBz8Mp_rNrh-Cuq_G--gHpw>
    <xmx:rC2TYD8SGDDIM9wA95nR0WDfOOi0Vuhz80gMceHKpwZ9_uG5PrSYhQ>
    <xmx:rC2TYCsj_Mq3QDyOMtGsb3suMkcnPlRYMYsdwVjSfOe1XStOElYyyQ>
    <xmx:rC2TYHWG4QXtaFGd1DUiaJseqfZLgXjwXsC59T953ZHCwc-Cn45hoQ>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed,  5 May 2021 19:43:40 -0400 (EDT)
Date:   Wed, 5 May 2021 16:43:38 -0700
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/187: fix test failure when using bash 5.0+ with
 debug enabled
Message-ID: <YJMtqnzfx5eYCHUd@zen>
References: <70ecc4413ac118ac95be3e76b0dabff237d70b8d.1619535331.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70ecc4413ac118ac95be3e76b0dabff237d70b8d.1619535331.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 27, 2021 at 04:00:09PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running btrfs/187 with a bash 5.0+ build that has debug enabled, the
> test fails due to an unexpected warning message from bash:
> 
>   $ ./check btrfs/187
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian9 5.12.0-rc8-btrfs-next-92 #1 SMP PREEMPT Wed Apr 21 10:36:03 WEST 2021
>   MKFS_OPTIONS  -- /dev/sdc
>   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>   btrfs/187 436s ... - output mismatch (see /xfstests/results//btrfs/187.out.bad)
>       --- tests/btrfs/187.out	2020-10-16 23:13:46.550152492 +0100
>       +++ /xfstests/results//btrfs/187.out.bad	2021-04-27 14:57:02.623941700 +0100
>       @@ -1,3 +1,4 @@
>        QA output created by 187
>        Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>        Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>       +/xfstests/tests/btrfs/187: line 1: warning: wait_for: recursively setting old_sigint_handler to wait_sigint_handler: running_trap = 16
>       ...
>       (Run 'diff -u /xfstests/tests/btrfs/187.out /xfstests/results//btrfs/187.out.bad'  to see the entire diff)
>   Ran: btrfs/187
>   Failures: btrfs/187
>   Failed 1 of 1 tests
> 
> This is because the process running dedupe_files_loop() executes the 'wait'
> command in the trap it has setup and very often it receives the SIGTERM
> signal while it is running the 'wait' command in the while loop of that
> function - so executing the trap makes bash run 'wait' while it is already
> running 'wait', triggering the warning message from bash.
> 
> That warning message was added in bash 5.0 by commit 36f89ff1d8b761
> ("SIGINT trap handler SIGINT loop fix"):
> 
>   https://git.savannah.gnu.org/cgit/bash.git/commit/?id=36f89ff1d8b761c815d8993e9833e6357a57fc6b
> 
> So fix this by making the trap set a local variable named 'stop' to the
> value 1 and have the loop exit when the local variable 'stop' is 1.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  tests/btrfs/187 | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/187 b/tests/btrfs/187
> index b2d3e4f0..7da09abd 100755
> --- a/tests/btrfs/187
> +++ b/tests/btrfs/187
> @@ -64,9 +64,19 @@ dedupe_two_files()
>  
>  dedupe_files_loop()
>  {
> -	trap "wait; exit" SIGTERM
> -
> -	while true; do
> +	local stop=0
> +
> +	# Avoid executing 'wait' inside the trap, because when we receive
> +	# SIGTERM we might be already executing the wait command in the while
> +	# loop below. When that is the case, bash 5.0+ with debug enabled prints
> +	# a warning message that makes the test fail due to a mismatch with the
> +	# golden output. That warning message is the following:
> +	#
> +	# warning: wait_for: recursively setting old_sigint_handler to wait_sigint_handler: running_trap = 16
> +	#
> +	trap "stop=1" SIGTERM
> +
> +	while [ $stop -eq 0 ]; do
>  		for ((i = 1; i <= 5; i++)); do
>  			dedupe_two_files &
>  		done
> -- 
> 2.28.0
> 
