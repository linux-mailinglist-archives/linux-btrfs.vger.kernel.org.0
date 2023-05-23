Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171E070D8E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjEWJXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjEWJXh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 05:23:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286C8132
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 02:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684833804; i=quwenruo.btrfs@gmx.com;
        bh=NqN/TrE9qTP7yqYqO5BrP8P6Nh1jYjbBbC3m9P8JYUA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Wm43CgbKb81EGY3rnLJaHfsMoVQhZ75vndzM8nTVRGnW9FzGEnvD4xbEZDBQUnLRP
         rNkuLs/hZ4h8P5cmfviNPFyFhIftoB/XEn1n2YmD5j3Wc30AubNzs6M8n0AWNVMY1i
         TBeE+bRdte6UDcQ4jWnqWYG68VP6Cg1GQTKJqkpZ7GIalojDNP627GcbsDLnPLz25Y
         nFQPDKXAMY+2mT5t4I9YEM5kvZN9D/GkaLI5cgeOBNj0kD5ywTreV1lxDaxbTvtFRw
         TqBOgXAFvF6pZpQ58TTzvHoOdhltG7X6n2xHF9t0/YxStMMG+a395CA4PgbNg3IPSl
         oisXcAZ7VNtFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpf3-1qPDL21H1r-00mMTh; Tue, 23
 May 2023 11:23:24 +0200
Message-ID: <3906cde3-a64a-889f-e0d6-00a6bf8c0fd0@gmx.com>
Date:   Tue, 23 May 2023 17:23:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 02/16] btrfs: factor out a btrfs_verify_page helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230523081322.331337-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L3X3/ymMkXC2vowFfVMOJgcvjCTyO6aM+STiESYu8kVnA5KFcvO
 uEVG//4dcTPZ7S/qiv8PTkT33p9ljYZinh7io+cGVl9YXLEfsYL37oZmSwyvbCme/fYs8lG
 TmjFFX61i7XBdp/wrdyGRrv6tb0glT4YxdxFTRpyLiC/r7CKCKaxjMbRu5S8myiJ/7TRV4C
 xF6RzNcpl9TzP48B48l+w==
UI-OutboundReport: notjunk:1;M01:P0:KngCJTjBpdo=;FKT6520zxPYsdCj6MEwTLGL5Fzp
 +LBM7Lpfw03VaMawglZK+QRF7dLnIIdylaqA1YvjBWLRT8PDSs5CiNALZi8d9Y20J+FbEwv6d
 SevIqC/fl4qCCR1pd16NoIjRIZHZHY+s3hkg5tn/FEuQu8q0HyZyrhkjcf3DNShus16NVlf2Z
 9WFhItdythMaGgRM1Y7RD/8EQgOQ3Dw/PMLyBm8BBkkAAbCHNufaI9ZTd+E4UapDAuS8yCqoe
 nk66LYOV6wVnYPjn/FZjNdDPCtYJtF9xQtC2Gah8Q+3znsz4N28q6pckwpamviBKciLkVw8BK
 GSReZ+Q2r+hOTpNYw7HgKNqDkIkQMtyF1lYWi0RkL5GBLy206MJcPa658h18no+mOB5ziWo/x
 malZb/lEIE68D4hKNSum6odFpEK1MlPD83Y0vyCaxgisR0kDIVb62USDp2AbfO9ogkYHYVzoz
 nXFnKAP7kRqcOa0HOSzLYWHlYn/CUgtW0fRUHwNGF88iZ/49R6yUu2zTCi0YKmh3yAEt6mHwL
 3mlREuQI2RCTkMtaECRbQrb9LzaJCXHc3ELdi937WwUNiT/QbZd9I3gvmM/QmK0KrS9wEcG3L
 LZZ3CmlKu3nO0Hs3dOp6nveRp+8IYjgMud1qESX5D+ppKzc1S2Rd/7ToxfYtAgKJYAQg2YUft
 Xuvye0ppuMqWm3pQ5cdyg4fBHC8nUN+lmmQAKk9R4H37qi/h6kbg+4Uk38HXDSBrCXN/ds284
 eyn0P0JiE83vdAcJBrsR92BCBBX9vYIiqUf98cn/c8xIuPYypJbohfiS2WvSQQerPwLxpnKbf
 Ps6EA03BvDpTipI7SfINmVchLiHzh2k9hOXblc3o7pY824ydOx458vh40HW9Av9b0d2x/3YcZ
 Mqb/C//HcwpnP73jTI4pbEp53hhK7hh5s1Fv20XYhlm1/98AKY082uOo9mBKJonDShpAT9WGS
 G3DuutP94ZwchBdIJyds2Yk3rVQ=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/23 16:13, Christoph Hellwig wrote:
> Split all the conditionals for the fsverity calls in end_page_read into
> a btrfs_verify_page helper to keep the code readable and make additional
> refacoring easier.

I know this patch is only doing refactoring, but this makes me wonder,
should we make the btrfs_verify_page() to be subpage compatible?

E.g. checking subpage page error and page uptodate?

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c1b0ca94be34e1..fc48888742debd 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -481,6 +481,15 @@ void extent_clear_unlock_delalloc(struct btrfs_inod=
e *inode, u64 start, u64 end,
>   			       start, end, page_ops, NULL);
>   }
>
> +static int btrfs_verify_page(struct page *page, u64 start)
> +{
> +	if (!fsverity_active(page->mapping->host) ||
> +	    PageError(page) || PageUptodate(page) ||
> +	    start >=3D i_size_read(page->mapping->host))
> +		return true;
> +	return fsverity_verify_page(page);
> +}
> +
>   static void end_page_read(struct page *page, bool uptodate, u64 start,=
 u32 len)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb)=
;
> @@ -489,11 +498,7 @@ static void end_page_read(struct page *page, bool u=
ptodate, u64 start, u32 len)
>   	       start + len <=3D page_offset(page) + PAGE_SIZE);
>
>   	if (uptodate) {
> -		if (fsverity_active(page->mapping->host) &&
> -		    !PageError(page) &&
> -		    !PageUptodate(page) &&
> -		    start < i_size_read(page->mapping->host) &&
> -		    !fsverity_verify_page(page)) {
> +		if (!btrfs_verify_page(page, start)) {
>   			btrfs_page_set_error(fs_info, page, start, len);
>   		} else {
>   			btrfs_page_set_uptodate(fs_info, page, start, len);
