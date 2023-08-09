Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8EE77666A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjHIRZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHIRZW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 13:25:22 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FAF1FEF
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 10:25:21 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-406b9bcad5dso36723301cf.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691601920; x=1692206720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmE+YDupI2mh5i/VjOnlKlW1CSHuX/qYIYuGEplFRi8=;
        b=Z2X9QWeeEzB/fty0cSl57K8f05RmC8b98Ra0+N3E7sCsi0eN/KX8jBY9QEWkn4UsYt
         jLTIYmaaG0L/cLh1Gbf33d2M0Lzrmyvh7ynN5l2AbxZ03IVSLUrals+RAMkbPKsN/CBt
         dYWkZ4/4c7zg8+2LsWPx0R0UXgs1YOKxqNPB8UK32AwZITxkNlF2DMTHiWj663XDrVCh
         mfRUReBZY5xFYx7gfSTHHY5wPmBNt0GC+MQ7ml6FCXx26RVcfZD5oUcnfLbs20imsZGg
         nSFTh46StRS6SO+65GpiM3vTRNICK17pzTCXZIgQ/U5GYuGbuMXFPPBXoVk23p7qqFVN
         H9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691601920; x=1692206720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmE+YDupI2mh5i/VjOnlKlW1CSHuX/qYIYuGEplFRi8=;
        b=GzvkPDp0Q3ALlBCyy+nYX/J9x8mDvhfzQB86u/76btlB/i80FvobBVDATWZ3aTGbnL
         jFVJdc3YCP0NqqWRAId+Ss7L3xZ61cmBfDb2M215hXPT8r85qpgI+pwr3pdHsmjWTzj7
         kzsN4rt+e0iUa0Bj6xeGxc7lpKrqACbEauL1zy7gmNcrZWmDWVapeUujJiN8YfZK4ZQY
         nY2zZJMw+jcXWMdGjKh6ROMUXC4KxNBCQyQFl5yIeWcYeT4D8uOQFCxAKbLoc7B3/xlu
         Oww55/NXf1HQO877rQ8S4UfqBpMLNX6L3GWZ98HyOPoQ6ampVg+WSg09ytmnPsDFQY46
         PAdA==
X-Gm-Message-State: AOJu0Yz2RwJ8jG7d9CIGzLOtEmW6/x50MTFbzTBVn7qIxePJ/BEK673k
        EmICEbVTxkFfdQdEIsWcYKBlWvW413HJgILO0930sg==
X-Google-Smtp-Source: AGHT+IHKjKJiPKbl9u24d4qCEmLsKueGUDH5B0NA+PEvONjgEGOH+ad1silnyDWb1RZ4c05B089ang==
X-Received: by 2002:ac8:7dc8:0:b0:403:ecfe:2a66 with SMTP id c8-20020ac87dc8000000b00403ecfe2a66mr4490264qte.57.1691601920153;
        Wed, 09 Aug 2023 10:25:20 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x4-20020ac81204000000b003f9efa2ddb4sm4150288qti.66.2023.08.09.10.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:25:19 -0700 (PDT)
Date:   Wed, 9 Aug 2023 13:25:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@meta.com,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v6 4/8] fscrypt: move dirhash key setup away from IO key
 setup
Message-ID: <20230809172518.GD2516732@perftesting>
References: <cover.1691505830.git.sweettea-kernel@dorminy.me>
 <729a2735c32cd9ddd9fb61c716643a39d10ae189.1691505830.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729a2735c32cd9ddd9fb61c716643a39d10ae189.1691505830.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:08:04PM -0400, Sweet Tea Dorminy wrote:
> The function named fscrypt_setup_v2_file_key() has as its main focus the
> setting up of the fscrypt_info's ci_enc_key member, the prepared key
> with which filenames or file contents are encrypted or decrypted.
> However, it currently also sets up the dirhash key, used by some
> directories, based on a parameter. There are no dependencies on
> setting up the dirhash key beyond having the master key locked, and it's
> clearer having fscrypt_setup_file_key() be only about setting up the
> prepared key for IO.
> 
> Thus, move dirhash key setup to fscrypt_setup_encryption_info(), which
> calls out to each function setting up parts of the fscrypt_info, and
> stop passing the need_dirhash_key parameter around.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
