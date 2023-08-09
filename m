Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30BB776A64
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 22:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjHIUkD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 16:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjHIUjx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 16:39:53 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338622D69
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 13:39:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63d48c3d242so1256666d6.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691613570; x=1692218370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hdsp4f6kSeHTVMeUFkh1SFhrM+fDakyg6bxkqo+FIk=;
        b=vdPh8+VFDDu0ZRGlQ1vOIdJ+pYdRA62op5kScf1T7LidYJ47MVh0YBANxt4u2qbACf
         1YO3YUkbkRx+NB2vS9qOPdAEAkut9N4v1unD9H9jdWfrvENYRjkqvLISO+xPq3LC3PQW
         9lzL3ZIwzkZxgoL1wTF7tsk0+9QnfCk28yyKScD+S/gqnidRWQfowqeGDwswPsjMR0Z9
         Djz6yzb74uAwvciM/o+cBIfZkheVFAG5fwes/rFooRAjOLKeDvOh5aSrophQs7A98kZ4
         swfzl4hV3QzdzetYKYdSNGFgQ1vf2DSniLP2lB6vT9dGiEu3yb3vXlZfqoFLHoyoWkSI
         DXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613570; x=1692218370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hdsp4f6kSeHTVMeUFkh1SFhrM+fDakyg6bxkqo+FIk=;
        b=CiOG8hbepctAfcVNjl7i3fP6DuAGDNq0S3YZa7oaPDUVxrjEw4JHwsbX7c7RYg6QuY
         YLcbcq+aMX342PzTO/aa/MA5r6IrhUJ3/I5NGgydBCX0oU8mmxzJRmko+t4ixw5FaGtA
         zXsGlZ/Id/B3/5BhFeu0COV8PDRd97y8fH4oU+EdntLAydI9NcpqHvLZaPRVCqjR1euU
         OFPuI3lnpFKcIFXwScKYdEJH8WA/4ALNecnBnSRVJpq9lMx9OciBKcP2UUH8PT+s8M1O
         FxhDq7Xc9wwIB6q5WsvJ0XyBoIRvKtLKWO/kuFBSNh1rkahWuEwKDhSrXwrsH2jEWMuZ
         ZsGQ==
X-Gm-Message-State: AOJu0YwxyD5kEv0gO2LxppKZ02HCI7T8MG1z8WQbbQx5U0yKKFj+Jz8g
        U3RXe62yA9EVnlBC3yn55BkZ0w==
X-Google-Smtp-Source: AGHT+IEmXzJ+7h/zdbMr6TYxvK9b5mAYMss7V/d9X9pFwbJLCLh2cqFTmqo2Gz7xTemsJsLCJO0Dhg==
X-Received: by 2002:a0c:aa17:0:b0:635:db0c:df78 with SMTP id d23-20020a0caa17000000b00635db0cdf78mr303773qvb.3.1691613570530;
        Wed, 09 Aug 2023 13:39:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y14-20020a0cf14e000000b0063d0f1db105sm4742458qvl.32.2023.08.09.13.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:39:30 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:39:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@meta.com,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v3 00/17] btrfs: add encryption feature
Message-ID: <20230809203929.GE2561679@perftesting>
References: <cover.1691510179.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691510179.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:12:02PM -0400, Sweet Tea Dorminy wrote:
> Encryption has been desired for btrfs for a long time, in order to
> provide some measure of security for data at rest. However, since btrfs
> supports snapshots and reflinks, fscrypt encryption has previously been
> incompatible since it relies on single inode ownership of data
> locations. A design for fscrypt to support btrfs's requirements, and for
> btrfs to use encryption, was constructed in October '21 [1] and refined
> in November '22 [2]. 
> 
> This patch series builds on two fscrypt patch series adding extent-based
> encryption to fscrypt, which allows using fscrypt in btrfs. The fscrypt
> patchsets have no effect without a user, and this patchset makes btrfs
> use the new extent encryption abilities of fscrypt.
> 
> These constitute the first of several steps laid out in the design
> document [2]: the second step will be adding authenticated encryption
> support to the block layer, fscrypt, and then btrfs. Other steps will
> potentially add the ability to change the key used by a directory
> (either for all data or just newly written data), allow use of inline
> extents and verity items in combination with encryption, and enable
> send/receive of encrypted volumes. This changeset is not suitable for
> usage due to the lack of authenticated encryption.
>  
> In addition to the fscrypt patchsets, [3] [4], this changeset requires
> the latest version of the btrfs-progs changeset, which is currently at
> [5], and the latest version of the fstests changeset, [6]. It is based
> on kdave/misc-next as of approximately now.
> 
> This changeset passes all encryption tests in fstests, and also survives
> fsperf runs with lockdep turned on, including the previously failing
> dbench test.
> 
> This version changes the format of extent contexts on disk as per
> Josef's comment on v2: the encryption field in file extents now only
> stores the fact of encryption with fscrypt, and the context stored at
> the end of the file extent now stores the length of the fscrypt extent
> as well as the fscrypt extent itself.
> 
> I remain really excited about Qu's work to make extent buffers
> potentially be either folios or vmalloc'd memory -- this would allow
> eliminating change 'fscrypt: expose fscrypt_nokey_name' and the code
> using it.
> 

Generally speaking I'm pretty happy with the state of this patchset.  Please do
the fixups I've asked for and refresh, but I think we're getting close to the
end here.  Thanks,

Josef
