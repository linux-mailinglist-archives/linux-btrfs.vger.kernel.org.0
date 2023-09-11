Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60ED79B0F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355750AbjIKWBw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbjIKSeu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 14:34:50 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C839F198;
        Mon, 11 Sep 2023 11:34:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 06AB63200912;
        Mon, 11 Sep 2023 14:34:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Sep 2023 14:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694457284; x=1694543684; bh=IF
        8gqeL+ErQjBAaEgRAFAOPP4+xIGg4ZWf75F8j7o+g=; b=oHm4ccriNXJZT9A27C
        3Wweh49Kbg+jYoKq2xGKakkYJ1TMYsrKQ5UR7PvC57UvxWoX9k/e0TKV0UnCju1o
        PY89loZRHsBLZFqQc0d0xOo1woPXKLo+dveCeQGcEFsYswn/1dBU50w24GSeqzco
        ylfOiQQnSTm74GMRjD6jcADFF/zjGxcy7GeDCoA8D1ddwHAf7+OK/pmA0YzCNfhp
        vEfPqsSpqmQ3bxzSZkvT+WSJvAMRmwfUoPn+pz9u4Vl51yVsUJUfN+QHiTeNTnmi
        hWyHJT8JPNJ2EC6vyPK6lgDYB2wEjd5Xm/j2/kDNKmbVc9/8fxIIKP5Qn18i6reL
        90cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694457284; x=1694543684; bh=IF8gqeL+ErQjB
        AaEgRAFAOPP4+xIGg4ZWf75F8j7o+g=; b=KV8aWZg051d1x+uq2UsuoNYBRtS64
        8VwFst1phf2UjiDulhhOMzWR8h9azeTA2Zk2HKdMRKZ7Bq9dET3ezRbINI2v4zSh
        ZUh5GT4yHUXgxuPlkIV75rZ1NURzMlH7nsyNu7sqX6yAzpbZabz2ep0RzX5CvY3+
        9c92UPOVbng2yWYIYWtsIkky7C7P9yjhhC03YtmJt9INmaeFZ9P7fID2XcXrA4nW
        WBhCInNd3vor00ONr7LmWFEIJJSqez2Zhz6xjfaEN8VpRHwUZyitKaJU5Qvbgo0z
        lNT6vr0IBS7B8AB3V9YdFes48gfeBzqPErQVLE6cPO4KYLBDFyg8cyZqg==
X-ME-Sender: <xms:xF3_ZAb7UjMrFrUXcy-qkvOHEYNKg-WSkGCSbrbiKTV2RAZHxK02IA>
    <xme:xF3_ZLZhWk3p4YepkMqHT1JP9yiRs6TplPYAgd0yFBmUM6lmjGqqBv4OT6jyYg3Ks
    VoqFN8_9_tWuB3-6mM>
X-ME-Received: <xmr:xF3_ZK92bQLl2lQm3z4KxZN-fJv8kUDqNF7HMEiSjNsLTXbUjNrDgSsq-edziitQW8xqkJlAbuScXLfhZwA_HQM3tRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeigedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:xF3_ZKoudNGIAERE4twxkzdFvtFMdenTVi0EJFCP0N3E-simWMYaSw>
    <xmx:xF3_ZLpeYD2jCvWSqeSyVKP1EnDPx2rtjA8mxeTMEEL1E5CoPy-aRQ>
    <xmx:xF3_ZIQNgtdJxGe6VUnwV5mXcEBnk7lxy8hSimUkUiVyxnschwJU7g>
    <xmx:xF3_ZECl3pggyMA44U-NbJPsyKEGcxEwcpsokfwEsYyVSmilsFAa0Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Sep 2023 14:34:43 -0400 (EDT)
Date:   Mon, 11 Sep 2023 11:35:42 -0700
From:   Boris Burkov <boris@bur.io>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/185 update for single device pseudo
 device-scan
Message-ID: <20230911183542.GA1770246@zen>
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
>  	rm -rf $mnt > /dev/null 2>&1
>  	cd /
>  	rm -f $tmp.*

Also, do we need to do the scratch_dev_pool_put on cleanup? Do we have
to worry about having not actually called scratch_dev_pool_get?

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
