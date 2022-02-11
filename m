Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC484B30F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 23:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiBKWnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 17:43:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiBKWnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 17:43:10 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDF0D54
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 14:43:07 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C1305C00FF;
        Fri, 11 Feb 2022 17:43:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Feb 2022 17:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=cSM2+paJXkqFJnr+Lus3QjAvW4zS6drAL3IT12
        vcWtE=; b=EuEQrZjypDJQBVBxPJN0mMTDqSD7wg6S1IyFH3hHw54DBI6CQZLSB2
        qt+mg1ImO7eSx+jO/3QCPVDy83fNOpQhs9X9ELkGUYa0Gg6FP3qROUsDLJOcjZYz
        84D6nP2m7vbrYxf9N7Y8Fwfx8TT1cJ5XcAp1k4o17nXZ03+q5ULbpqNoh7mfGEmL
        hOfjgt3yDgPY6Zywg8uMqKRHx3GnR4omasZU6N1SLL3qHBJIbRb03HriGaUcbhWQ
        tpDS1GOS1aXB2oxQTAt8S7LeY4MVE1k8v4D3RIDv+OGd3e6ANkELgJ6Y3GVWup9X
        Z74IfA+nLTGzp0ZioBcP5sI7x6tYhp+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cSM2+paJXkqFJnr+L
        us3QjAvW4zS6drAL3IT12vcWtE=; b=L13ZFub6YNq41obqFju+qWvqXs1R2cG8g
        BYy4h85o9Cde2/j5z3XA7EY7bznRC5Ey5hTwLy/e9VJ8aACmRWIOQ+9qIaO0nG9d
        tdBprIb8fhDpBMPESFtX9eMd4zDEETJAr4/+GT2uCGtNfjZxlpfmGJIo0/pefC67
        KjnVx+6gwmA9rsI6U+VIBPzCbJ8dLc60sZ7TbOQmy/8WHfZcPuTcwWhsenKJ66T4
        2iptqXynHAMolyJETHsibWO54njqS4qTUcUuniFFx56z3TgWOj0soAG7SK27esgz
        lWYRciWtJFycm/R79m2xui97i+wZEgXBBgW9AUhLIEW8+W5GSMPmg==
X-ME-Sender: <xms:e-YGYkfYF2YDE6to0QpTaPMLSKReItpv6_AKi21LEtc3Syu576-gDA>
    <xme:e-YGYmP84B_fpifV_Chix18NKbmT-EqIAoa7I6BSA5zbgE0RQKBi7iYL3HGTdHoXY
    Kq9AZ3u79DhDdOooag>
X-ME-Received: <xmr:e-YGYljAMDLeR2VHxvKt3-tCvQCRY8WwJslbLjQQJpo3hsoR-zbc69NvAcyyCKAGV4iHDZeku7ye5FioMMPWwfAsWJVyog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehff
    dvudfgveefgfejiedvhfekiefghfeujeetjeegffduffdtheevueeuvedtkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:e-YGYp9hlBH4IOVJBu4O7nSijH1W39HWWyw1Qa7oMk-dDZpepgAkHQ>
    <xmx:e-YGYgsvuujxaqKZeJmiFF_udxYhaWb2dpifW_cy8kqZG1-bmtgmqg>
    <xmx:e-YGYgGGlMaz8oJap2wmw_BuK4rUng17o_GAcv4olwG3yQz16j9P9Q>
    <xmx:e-YGYtVhFGXQzhiBzwnuzV-NKk78YBjhbMAFRG91NkPMSPJ1-Q3Dbw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 17:43:06 -0500 (EST)
Date:   Fri, 11 Feb 2022 14:43:05 -0800
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/8] btrfs: check correct bio in
 finish_compressed_bio_read
Message-ID: <YgbmeebSNcRFEnMY@zen>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <04d361b2ca1bdf0470e9fdbba00eecd801d18268.1644532798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d361b2ca1bdf0470e9fdbba00eecd801d18268.1644532798.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 05:44:21PM -0500, Josef Bacik wrote:
> Commit c09abff87f90 ("btrfs: cloned bios must not be iterated by
> bio_for_each_segment_all") added ASSERT()'s to make sure we weren't
> calling bio_for_each_segment_all() on a RAID5/6 bio.  However it was
> checking the bio that the compression code passed in, not the
> cb->orig_bio that we actually iterate over, so adjust this ASSERT() to
> check the correct bio.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/compression.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 71e5b2e9a1ba..a9d458305a08 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -259,7 +259,7 @@ static void finish_compressed_bio_read(struct compressed_bio *cb, struct bio *bi
>  		 * We have verified the checksum already, set page checked so
>  		 * the end_io handlers know about it
>  		 */
> -		ASSERT(!bio_flagged(bio, BIO_CLONED));
> +		ASSERT(!bio_flagged(cb->orig_bio, BIO_CLONED));
>  		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all) {
>  			u64 bvec_start = page_offset(bvec->bv_page) +
>  					 bvec->bv_offset;
> -- 
> 2.26.3
> 
