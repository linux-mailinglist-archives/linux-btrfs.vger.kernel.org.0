Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6179D61E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbjILQVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 12:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjILQVI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 12:21:08 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F2A10D;
        Tue, 12 Sep 2023 09:21:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4E191320015C;
        Tue, 12 Sep 2023 12:21:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 Sep 2023 12:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694535663; x=1694622063; bh=bd
        A1iPBWfJ8ilz2CI4YqHgs4y7WKGAYP1oAcAbMvzzU=; b=hlCUaiuPFcguqhJrTs
        yt5gRUdqZv9m8uwKi/gvKbsjnNcVhETRdaskKAEzTsrzcVl8VsSkIwoPpR4XrwSd
        GI0rRQs15WC1e8JsGI9GCNmT7wlWhkYLIPMamlv/iqbicIF/s9fjjo+T4DOS2Hj6
        QcTgov812umRN9BvrsjjSHiDgLkd1w8sX2ncACWM5BfHEdHZO1yP8msUyEWrBP27
        DFfB9WhjXz9/gPmBGpWaMVEf2iv+IHToR6e57AjnqPKnIzgETvJVWfwZpzbmg/qc
        DiiJr39xMvyfgS13Ia87BHb7n3lSmPerGe0pldry/bh834QbVeG9+11q20N7RbI7
        t8aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694535663; x=1694622063; bh=bdA1iPBWfJ8il
        z2CI4YqHgs4y7WKGAYP1oAcAbMvzzU=; b=MDoXhS7fF08AF9RWU0IAZKm5Omzpo
        zCp+thyPAesbER4Acyo16Y8pK47vOSvRpWgw7mSDeRTBKGG6cBAVI7sWCV1XaIcT
        1ELUPtGLN9IIIcLK/71jf7AzZOnFBdl8U+HLBkSBIR58xj366Q0V2oyjNIxmOlU2
        /TCipvPctYSccfr8TsGRF7KTy4XOwci3/pBSMzpHj1k4xUhGk+Ha4y6Di59KEkR4
        U9k1vPjmCw+W1Fqb3L+2b6Fw0VwlVbxl32DjuYelvT+hdsXXcewVtTs7iUZks7xB
        L+vS0bGA6IDU76A9QRwSo+6BJgBSSj5xQalEfwsNBlW3cpij+sQp3/3DQ==
X-ME-Sender: <xms:748AZeBsNU5fI-kzcc37dAnBl4wSelJ61ylOk8nCkqoqvV5hJrrOhw>
    <xme:748AZYi3BjMeAIvrsheNAvDVQETwJzzCSHri9eKvEoMFFuI2pnXcAvwaRepGwL2ya
    D1da8o1cImrTWR7Tqw>
X-ME-Received: <xmr:748AZRmtgNuIv9ohYBj_10tuSMEkVsCjlQvSqPJvDinBeeauPAHkxEtJfUcuZL-X1_1DF_1RsGAOk6b1QM5SahGDgk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:748AZcyVPZd1OL6D4WqWVUv4BPHBJ17VMV7hz0AClyasNokXNQD_4w>
    <xmx:748AZTTUIfb0OdgiIuuyj_mpmP83xhtwpYcoDQifexLCWwu7eHl58A>
    <xmx:748AZXau5GkYtdQ1X7qDgx-jfZ76eaCQWKoXJl-EmRzbSYA1hSx3Jg>
    <xmx:748AZaIOzTTBAHVUmusckF3bekDT57WQnThjLqo-dqPBvzYUZa_S0Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 12:21:03 -0400 (EDT)
Date:   Tue, 12 Sep 2023 09:21:58 -0700
From:   Boris Burkov <boris@bur.io>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/185 update for single device pseudo
 device-scan
Message-ID: <20230912162158.GA962832@zen>
References: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
 <20230911183219.GA1770132@zen>
 <c4f62adc-a923-e253-2731-f27fb6cf5ae9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f62adc-a923-e253-2731-f27fb6cf5ae9@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 12, 2023 at 05:07:49PM +0800, Anand Jain wrote:
> 
> 
> On 12/09/2023 02:32, Boris Burkov wrote:
> > On Thu, Sep 07, 2023 at 12:24:43AM +0800, Anand Jain wrote:
> > > As we are obliterating the need for the device scan for the single device,
> > > which will return success if the basic superblock verification passes,
> > > even for the duplicate device of the mounted filesystem, drop the check
> > > for the return code in this testcase and continue to verify if the device
> > > path of the mounted filesystem remains unaltered after the scan.
> > > 
> > > Also, if the test fails, it leaves the local non-standard mount point
> > > remained mounted, leading to further test cases failing. Call unmount
> > > in _cleanup().
> > 
> > This was also affecting my setup, thanks for the fix!
> 
> Hmm, it shouldn't, unless commit d41f57d15a90 ("brfs: scan but don't
>  register device on single device filesystem") is already in the kernel
>  you are testing. Do you have the logs?

I was testing on top of misc-next and that patch was indeed present.

> 
> 
> > 
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> > > ---
> > >   tests/btrfs/185 | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/btrfs/185 b/tests/btrfs/185
> > > index ba0200617e69..c7b8d2d46951 100755
> > > --- a/tests/btrfs/185
> > > +++ b/tests/btrfs/185
> > > @@ -15,6 +15,7 @@ mnt=$TEST_DIR/$seq.mnt
> > >   # Override the default cleanup function.
> > >   _cleanup()
> > >   {
> 
> 
> 
> > > +	$UMOUNT_PROG $mnt > /dev/null 2>&1
> > 
> > Do you mean to umount before calling rm -rf on it? That seems.. risky.
> > 
> > >   	rm -rf $mnt > /dev/null 2>&1
> 
> mnt is a special mount point. Removing the special mnt directory after
> unmounting it is correct..

D'oh, you're totally right, my bad!

> 
> 
> > >   	cd /
> > >   	rm -f $tmp.*
> > > @@ -51,9 +52,9 @@ for sb_bytenr in 65536 67108864; do
> > >   	echo ..:$? >> $seqres.full
> > >   done
> > > -# Original device is mounted, scan of its clone should fail
> > > +# Original device is mounted, scan of its clone must not alter the
> > > +# filesystem device path
> > >   $BTRFS_UTIL_PROG device scan $device_2 >> $seqres.full 2>&1
> > > -[[ $? != 1 ]] && _fail "cloned device scan should fail"
> > >   [[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') != $device_1 ]] && \
> > >   						_fail "mounted device changed"
> > > -- 
> > > 2.39.3
> > > 
