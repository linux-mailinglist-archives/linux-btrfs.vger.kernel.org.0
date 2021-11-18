Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4276F45632F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 20:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhKRTLr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 14:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhKRTLr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 14:11:47 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DF0C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 11:08:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x7so5949676pjn.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 11:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3xOn/rNCsxUH6EUkHlHu2F/UMPge6hzXDN0jgl7pRsY=;
        b=S0uFippF6bfBaIFEQjE8rwEMT2B8T/LOzXW7mVHKz288HsA18/Tsw0p7bJUnuY7pUx
         CXvTGe9iV2gxcKcSiBcdfecTuxopHF0mcmrXluj1L6I+pVB/gjgY7nup3Em3bQvOmIHe
         T5KAMLYN9g72d8iajbPmVdOMdtsfv+dLbO7I2cyCyzFm2w+Pczc+rDGFly2mT5UvtNuH
         N63Ii5Mg99DG2NnIiBFxsyhWOMERvAJ0AWfBmTYbWHAMzsacwRILjjN7gjL6WPH9tkq0
         xMC6lWil01QgOrqtqH8EEDiJ8vxmFU9r5/d49++L0DTeA8ROHh0ehsF7QfX4v/60zXld
         nHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3xOn/rNCsxUH6EUkHlHu2F/UMPge6hzXDN0jgl7pRsY=;
        b=uBxRU0vBoxtiw1mVM5Az8tvwbBwHNRhY/Y6njO7eV0l+cKAN9YOHfpQQMopeMP20Ln
         w71lv8lMzsTGFrQHSuJJxlcFUn1w2nvHf9RUBdpAK1WHgPAdduIacOJDo0rG3SY5vz7P
         90uUI4/LJe34L9QLCo0blg+ov0ItSy/XrnEqUuGvZEq8PR3/Y5JQ73mAJeqTD2sSKWTm
         Ytzrc6MtSY4MxyQ7zWvSStmV72pSUTFdnY38BSJTEnCjIMPgxl0VqZsfYkVymBQPSNvC
         cf09frHNRMCsaVt7Ap126KUN/Ta9k7goSkgDfbYYp8fgtLoTaiwhY13BPrKQE73JLVaW
         Vtfw==
X-Gm-Message-State: AOAM5327mMPFJARpXFLIoMrLYg371tujMOkcQxiGSCUnwTfyp6farwJQ
        x8npk5TWKwI/rkv6tZ/U7HlsVw==
X-Google-Smtp-Source: ABdhPJwcB8E5E2L2Eaon4mCuLrGh0CBifRtJMwOAgatQ3ZsllVP9NuDQ8RC0VZ8d6Dt4DaaDtq+6Bg==
X-Received: by 2002:a17:90a:fd13:: with SMTP id cv19mr13316018pjb.54.1637262519815;
        Thu, 18 Nov 2021 11:08:39 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:174e])
        by smtp.gmail.com with ESMTPSA id h194sm345447pfe.156.2021.11.18.11.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 11:08:39 -0800 (PST)
Date:   Thu, 18 Nov 2021 11:08:37 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 13/17] btrfs: add send stream v2 definitions
Message-ID: <YZaktVumi4OvLT8l@relinquished.localdomain>
References: <cover.1637179348.git.osandov@fb.com>
 <09f343aa74b5cb2ce0a715f90c71ae64ae74ce94.1637179348.git.osandov@fb.com>
 <20211118141847.GC28560@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118141847.GC28560@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 03:18:47PM +0100, David Sterba wrote:
> On Wed, Nov 17, 2021 at 12:19:23PM -0800, Omar Sandoval wrote:
> > @@ -113,6 +121,11 @@ enum {
> >  	BTRFS_SEND_A_PATH_LINK,
> >  
> >  	BTRFS_SEND_A_FILE_OFFSET,
> > +	/*
> > +	 * In send stream v2, this attribute is special: it must be the last
> > +	 * attribute in a command, its header contains only the type, and its
> > +	 * length is implicitly the remaining length of the command.
> > +	 */
> >  	BTRFS_SEND_A_DATA,
> 
> I don't like the conditional meaning of the DATA attribute, I'd rather
> see a new one that's v2+. It's adding a complexity that's not obvious
> without some context.

Hm, I could add a BTRFS_SEND_A_DATA2, but then we'd need something like
this on the parsing side:

diff --git a/common/send-stream.c b/common/send-stream.c
index f25450c8..d6b0c10b 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -189,7 +189,7 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 
 		pos += sizeof(tlv_type);
 		data += sizeof(tlv_type);
-		if (sctx->version == 2 && tlv_type == BTRFS_SEND_A_DATA) {
+		if (tlv_type == BTRFS_SEND_A_DATA2) {
 			send_attr->tlv_len = cmd_len - pos;
 		} else {
 			if (cmd_len - pos < sizeof(__le16)) {
@@ -456,7 +456,10 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	case BTRFS_SEND_C_WRITE:
 		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
 		TLV_GET_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, &offset);
-		TLV_GET(sctx, BTRFS_SEND_A_DATA, &data, &len);
+		if (sctx->cmd_attrs[BTRFS_SEND_A_DATA2].data)
+			TLV_GET(sctx, BTRFS_SEND_A_DATA2, &data, &len);
+		else
+			TLV_GET(sctx, BTRFS_SEND_A_DATA, &data, &len);
 		ret = sctx->ops->write(path, data, offset, len, sctx->user);
 		break;
 	case BTRFS_SEND_C_ENCODED_WRITE:
@@ -476,7 +479,10 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 			TLV_GET_U32(sctx, BTRFS_SEND_A_ENCRYPTION, &encryption);
 		else
 			encryption = BTRFS_ENCODED_IO_ENCRYPTION_NONE;
-		TLV_GET(sctx, BTRFS_SEND_A_DATA, &data, &len);
+		if (sctx->cmd_attrs[BTRFS_SEND_A_DATA2].data)
+			TLV_GET(sctx, BTRFS_SEND_A_DATA2, &data, &len);
+		else
+			TLV_GET(sctx, BTRFS_SEND_A_DATA, &data, &len);
 		ret = sctx->ops->encoded_write(path, data, offset, len,
 					       unencoded_file_len,
 					       unencoded_len, unencoded_offset,

It doesn't really make reading the attribute any clearer, and then we
have to check for two attributes. But, if you prefer it this way, I can
change it.

P.S. if we stick with my way, that sctx->version == 2 should probably be
sctx->version >= 2
