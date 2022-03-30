Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337A14ECA47
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245642AbiC3RH7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 13:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347347AbiC3RHo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 13:07:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4E412AE8
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 10:05:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t2so19334307pfj.10
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SGY9WxpQlRIhdgAMHq7V7ZX9v/wZnd6/iFY+5EG1Ay4=;
        b=sl2Z8OGtLWqrcC+ZywX+dGbBxGMB7TlNnYaFUNe2Fms0TMCxnre0BvEL+nRicW4+91
         bIAadEsUDkj5WRPwzGE7wK8wRTx890mEpOdF+jun5SN9XoflfrYafrRwXJDhpEhc6l8F
         ZBqRmsqw1rcMsC9iO2UWBfIH0Z0hkwTdGeickTp1ICSm+4e6MEXFiufhkADCwbk9+4/W
         SmiCf5YoifdTtg0A2uROWLqoDQ4L0HoVpDlkzb0IOFRmtp+3AtpL4hUKJ/XJ6aFlYI1d
         vmrBZ93NIJVEaloB7lkWEWnBS7sGetDT8pyG0b0k1a35KgL3nVf2ugycabwZWnXTCW3Y
         Imag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SGY9WxpQlRIhdgAMHq7V7ZX9v/wZnd6/iFY+5EG1Ay4=;
        b=d2vFCwP97vuZRKLS9LDce5rpFxKd/mC+XEQ6rMOasvUF2C7cSdjvYkia2SSUF1QpZ9
         K45p6yl3ikxz6MuOCQCxpRZ6XqNvrFBlhN9eahEVYmZhU8SH8g5YJ20RlRcUS5LwtfId
         jLDxsipiviRGWXbCz63ZKYmrjFpaxDcmilDsNLzPth7bipuOQiGIAdsAUW4KAfsm+JEP
         FeTt6HyfYwNOMlvInIwHAtF07o2q7PEZk7U12z9LMe3thjmW5PXuZA8Ea017t697KuzN
         aGj7rnbpcrIcAyM+vK71xQ1u7QMzVa0xDft37WqVECLbgfGzZVvMioxH+2OVyA7opnFk
         DcYQ==
X-Gm-Message-State: AOAM532LJddYE7XYarKRrunoGRK+Oohodg70WYVLVJERk4UmhyZQ0ROO
        3J59+z+oyo2unGMDlEzmBxr/lA==
X-Google-Smtp-Source: ABdhPJw4+9dA/DpFwprv+1QJnKspdKOjtKfZOwtdA2ba95tQ7+6SWIADSwSymIE6cEwYDu0JXFOc1A==
X-Received: by 2002:a05:6a00:130e:b0:4f3:9654:266d with SMTP id j14-20020a056a00130e00b004f39654266dmr465209pfu.59.1648659959014;
        Wed, 30 Mar 2022 10:05:59 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:7694])
        by smtp.gmail.com with ESMTPSA id u9-20020a056a00158900b004faad3ae570sm25297130pfk.189.2022.03.30.10.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:05:58 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:05:57 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v14 4/7] btrfs: send: write larger chunks when using
 stream v2
Message-ID: <YkSN9bKLA8m2/0Lh@relinquished.localdomain>
References: <cover.1647537027.git.osandov@fb.com>
 <2ac307b0d20f84a09302d9d4f7c4fa1207edccc7.1647537027.git.osandov@fb.com>
 <757b48b9-db01-e8d0-ec64-02443828dd7a@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757b48b9-db01-e8d0-ec64-02443828dd7a@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 24, 2022 at 01:52:53PM -0400, Sweet Tea Dorminy wrote:
> 
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 1f141de3a7d6..02053fff80ca 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -82,6 +82,7 @@ struct send_ctx {
> >   	char *send_buf;
> >   	u32 send_size;
> >   	u32 send_max_size;
> > +	bool put_data;
> put_data's use seems to be about making sure put_data_header() isn't called
> more than once, which is not super obvious to me from the name; perhaps one
> of 'data_header_{set,setup,initialized}' might make it clearer? Or if it's
> actually about put_file_data, maybe moving the assertion there would make
> that clearer?

The intention is to prevent adding another attribute after a data
attribute, since that's impossible with v2. Notice that it's also
checked in tlv_put(). So "put_data" means "was a data attribute already
added to this command?"; it's not specifically about the data header or
data itself. I'll add a comment to that effect.

> >   static int put_data_header(struct send_ctx *sctx, u32 len)
> >   {
> > -	struct btrfs_tlv_header *hdr;
> > +	if (WARN_ON_ONCE(sctx->put_data))
> > +		return -EINVAL;
> > +	sctx->put_data = true;
> > +	if (sctx->proto >= 2) {
> > +		/*
> > +		 * In v2, the data attribute header doesn't include a length; it
> > +		 * is implicitly to the end of the command.
> > +		 */
> > +		if (sctx->send_max_size - sctx->send_size < 2 + len)
> > +			return -EOVERFLOW;
> > +		put_unaligned_le16(BTRFS_SEND_A_DATA,
> > +				   sctx->send_buf + sctx->send_size);
> > +		sctx->send_size += 2;
> > +	} else {
> > +		struct btrfs_tlv_header *hdr;
> > -	if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
> > -		return -EOVERFLOW;
> > -	hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
> > -	put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
> > -	put_unaligned_le16(len, &hdr->tlv_len);
> > -	sctx->send_size += sizeof(*hdr);
> > +		if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
> > +			return -EOVERFLOW;
> > +		hdr = (struct btrfs_tlv_header *)(sctx->send_buf +
> > +						  sctx->send_size);
> > +		put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
> > +		put_unaligned_le16(len, &hdr->tlv_len);
> > +		sctx->send_size += sizeof(*hdr);
> > +	}
> >   	return 0;
> >   }
> 
> I wish the 2s were named, and that there were more commonality between the
> two branches... Might I propose this alternative? It doesn't check the
> length's suitability until after adding the two fields, but I don't think
> anything bad happens from delaying the check.

We need to check that writing the header itself won't write past the end
of send_buf, so it'd have to look more like:

static int put_data_header(struct send_ctx *sctx, u32 len)
{
	struct btrfs_tlv_header *hdr =
		(struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size)

	if (WARN_ON_ONCE(sctx->put_data))
		return -EINVAL;
	sctx->put_data = true;

	if (sctx->send_max_size - sctx->send_size < sizeof(hdr->tlv_type))
		return -EOVERFLOW;
	put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
	sctx->send_size += sizeof(hdr->tlv_type);

	/*
	 * In v2, the data attribute header doesn't include a length; it is
	 * implicitly to the end of the command.
	 */
	if (sctx->proto < 2) {
		if (sctx->send_max_size - sctx->send_size <
		    sizeof(hdr->tlv_len))
			return -EOVERFLOW;
		put_unaligned_le16(len, &hdr->tlv_len);
		sctx->send_size += sizeof(hdr->tlv_len);
	}

	if (sctx->send_max_size - sctx->send_size < len)
		return -EOVERFLOW;

	return 0;
}

Now we're checking for overflow in three places, shrug.

One thing that I like about the two separate cases is that it makes it
more clear that v2+ doesn't actually have a btrfs_tlv_header; it's just
a single __le16. If it's alright with you, I'll stick with my original
version, but I will replaced the hard-coded 2s with sizeof(__le16).
