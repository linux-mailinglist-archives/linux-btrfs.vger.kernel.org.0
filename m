Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0114379AEB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355873AbjIKWCP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243953AbjIKSbc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 14:31:32 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C61198;
        Mon, 11 Sep 2023 11:31:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E2EA83200912;
        Mon, 11 Sep 2023 14:31:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Sep 2023 14:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694457083; x=1694543483; bh=Ec
        MFYvhUrMnasEqJwEyJPej38pS4lZZ3N7GELDh7r38=; b=nMcci+o/59MCemrXW5
        8dcZVnfHs5GPM/Dq4tcYijrGi7fvsxjxnWFulAC+EaeWcnl3ZwVgO7HOZ8kx268J
        v3J5+OGvDxhy13nngEYTNboVIzpeafHZ+HFPftahw0sACD266c3kbfX4Vc2cXwtR
        guQMSJV37NO13UnGXSzRuLPMURW4gK49vti+MfkO9Rw2Fm5cp2ev8btsP22PKoGw
        43U7F1WShYKCs4fNKvClrt+NYXWBRiBLZKbbwVGTTUdr1tLhbPHnP+KJTDd0PJA0
        h/WrFRkJQTs+2bIqEzNrp7S+Ph8Vx7MPWYS9p5+mBn6ZbIkzKk7Ln8wbEQMEXsxF
        jjtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694457083; x=1694543483; bh=EcMFYvhUrMnas
        EqJwEyJPej38pS4lZZ3N7GELDh7r38=; b=vsmmCu4Nv39Ay3NHLb3N2iQhwjdzZ
        BHtUv5ei4e6U18ndUC855+9I8tupLZfAvGOrKojYzPcKvyGm9rbUYicMFehpzWi6
        VTWygoxtHLzqZFVbBngs5RmEKrdpeqAD/4wJn9t52HZk9DZFotfluoEsFGiBsQMF
        7Vi7rZS4i2Ot48+hvYOwK6fBAUSsAr/KsMzwvwYKzJATlEcKEyx8fWZODYQX7pDW
        WV0hMtqoZKrnPzL6zpxcYHvN7NbX97pcPiDQdqSBq50iF+L/VAP3MV/UnDl4PlhH
        X1dQF2fxUGBkGuLXAOee0jgFpplCm4rWaxLFo1pnmic4vsJjTGgm+yXmA==
X-ME-Sender: <xms:-lz_ZJV4NRGW4-f1uSPJpD7Oxc8MxeJspcisSUu-1QcSt5YLYqca2g>
    <xme:-lz_ZJlRbAVOz4Ei9KNaGwr7vZRP4h9Ldi-Eng8xmjdYceIDn1ZieZuJTuJ9p2pjW
    yOEquAQ-P6-djvLve4>
X-ME-Received: <xmr:-lz_ZFaM2n4rds7OPzAmWpOwf_9VWzGQKFXX2HcHmvutSQGy0kgkXcOWwATYCY-NqEvExsAQTZFn-69Pp1EojYdvgo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeigedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:-lz_ZMVwTpWjiCQ1Vxt_CmqHxv309uYBiPfgXqCLX1PsG4iWeuhLmA>
    <xmx:-lz_ZDnGlhPaDrEhBiaWcUznyk3y9N6iqr2sFtOmoS_5TqXw4OvaPw>
    <xmx:-lz_ZJc4vHhoT5JBEyY8ouXTZBxcHtl7K5IPajJLiXIe2e0sL2ifww>
    <xmx:-1z_ZLvv9rmbrXM3dNZ0bG1VPErrBmXwyt3b8OS0BjizFISdtHhyzA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Sep 2023 14:31:22 -0400 (EDT)
Date:   Mon, 11 Sep 2023 11:32:19 -0700
From:   Boris Burkov <boris@bur.io>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/185 update for single device pseudo
 device-scan
Message-ID: <20230911183219.GA1770132@zen>
References: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 12:24:43AM +0800, Anand Jain wrote:
> As we are obliterating the need for the device scan for the single device,
> which will return success if the basic superblock verification passes,
> even for the duplicate device of the mounted filesystem, drop the check
> for the return code in this testcase and continue to verify if the device
> path of the mounted filesystem remains unaltered after the scan.
> 
> Also, if the test fails, it leaves the local non-standard mount point
> remained mounted, leading to further test cases failing. Call unmount
> in _cleanup().

This was also affecting my setup, thanks for the fix!

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/185 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/185 b/tests/btrfs/185
> index ba0200617e69..c7b8d2d46951 100755
> --- a/tests/btrfs/185
> +++ b/tests/btrfs/185
> @@ -15,6 +15,7 @@ mnt=$TEST_DIR/$seq.mnt
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	$UMOUNT_PROG $mnt > /dev/null 2>&1

Do you mean to umount before calling rm -rf on it? That seems.. risky.

>  	rm -rf $mnt > /dev/null 2>&1
>  	cd /
>  	rm -f $tmp.*
> @@ -51,9 +52,9 @@ for sb_bytenr in 65536 67108864; do
>  	echo ..:$? >> $seqres.full
>  done
>  
> -# Original device is mounted, scan of its clone should fail
> +# Original device is mounted, scan of its clone must not alter the
> +# filesystem device path
>  $BTRFS_UTIL_PROG device scan $device_2 >> $seqres.full 2>&1
> -[[ $? != 1 ]] && _fail "cloned device scan should fail"
>  
>  [[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') != $device_1 ]] && \
>  						_fail "mounted device changed"
> -- 
> 2.39.3
> 
