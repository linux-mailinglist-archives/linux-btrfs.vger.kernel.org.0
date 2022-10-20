Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40266069E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 22:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJTUwG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTUwF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 16:52:05 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FA5194FBE
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 13:52:04 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 8so793279qka.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 13:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=av5V+WheLiDAHJF0b7an8Md+TjzU0+zz397YBrxXlTw=;
        b=r70rtr5AXbl5b5tLDkIscd9pbipR2zArcKNoNdm9+LO7KIZrhAZB6d1kyvY8i3lwPh
         +knJacn53H+wZUKZ11KqtEIs7zx/N+j47PabYVLcO8gLdgc4hJeZPfVAtthUHjjEgcWD
         IJPG440FZ+u0xtBUwGDW0KwDf0DJZHXiYqYQgH7ZS50v5xM847gFWvzysqrOdo0CndEa
         KJ3ZwaM+itilkRN/9WMtGMuGOpjbBj6XeSNvHb9ve2oEE0W11TLLIyVzjsvV4QfQnP2I
         VkBQoZ43M7fHNj8HW1NyJl5ZGbudSap/6ExijTmdxMHNE5//8/N99JEEAorASXvP6JXr
         DGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av5V+WheLiDAHJF0b7an8Md+TjzU0+zz397YBrxXlTw=;
        b=olpBH66LJTkdPTKtQKqMIsqopSh9e6aq5zVC4dLDkDWHIbjmULXoL5g3JHJ1g2xNKX
         SuuujQduvLboyCSMeCMzvBWshokYfQV24S1HxYmGkYGJ9HgrYmArvivudcPR0++ZtnKV
         +dvbt9Pl01cf/1UamheRPsJzzhZ4NrY/lc89KVtP3lbnbF/MatRkxaCxkm73YhwdsROh
         OjnkbJu7WDAgbnAgSVyTurrYdbAzjTBfgdL1dNTO5U9uGIZSzyZpn+mU7Q2u3S2EgH2a
         T7yWVx8fWe0QMK3434OzGLUMzLuzM3DZZ8usIrapb64nNqtpTJ10agyPsjYnt1TTczag
         1FPA==
X-Gm-Message-State: ACrzQf2MmBCBgWNNfyP/tVahHLGognOH8UzX0AqlOGLlyyxfVbr2roPG
        hpeW05HHkWed2DbyPikfx71ryw==
X-Google-Smtp-Source: AMsMyM6Tx1YV8cs3l45QaFzSAhH9VLgpVxHNyIFBlYpPZ24uuSy8/81D5UDFaOu5Ej8xxaWdKw2UEg==
X-Received: by 2002:a05:620a:e8c:b0:6ee:7820:fa2a with SMTP id w12-20020a05620a0e8c00b006ee7820fa2amr10962914qkm.624.1666299123654;
        Thu, 20 Oct 2022 13:52:03 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006ceb933a9fesm7889783qkk.81.2022.10.20.13.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:52:03 -0700 (PDT)
Date:   Thu, 20 Oct 2022 16:52:01 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v3 02/22] fscrypt: add fscrypt_have_same_policy() to
 check inode compatibility
Message-ID: <Y1G08XNhCr9o1ANi@localhost.localdomain>
References: <cover.1666281276.git.sweettea-kernel@dorminy.me>
 <48538f6e8b733d4e273510491a40a162545a7300.1666281277.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48538f6e8b733d4e273510491a40a162545a7300.1666281277.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 20, 2022 at 12:58:21PM -0400, Sweet Tea Dorminy wrote:
> From: Omar Sandoval <osandov@osandov.com>
> 
> Btrfs will need to check whether inode policies are identical for
> various purposes: if two inodes want to share an extent, they must have
> the same policy, including key identifier; symlinks must not span the
> encrypted/unencrypted border; and certain encryption policies will allow
> btrfs to store one fscrypt_context for multiple objects. Therefore, add
> a function which allows checking the encryption policies of two inodes
> to ensure they are identical.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  fs/crypto/policy.c      | 26 ++++++++++++++++++++++++++
>  include/linux/fscrypt.h |  7 +++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> index 46757c3052ef..b7c4820a8001 100644
> --- a/fs/crypto/policy.c
> +++ b/fs/crypto/policy.c
> @@ -415,6 +415,32 @@ static int fscrypt_get_policy(struct inode *inode, union fscrypt_policy *policy)
>  	return fscrypt_policy_from_context(policy, &ctx, ret);
>  }
>  
> +/**
> + * fscrypt_have_same_policy() - check whether two inodes have the same policy
> + * @inode1: the first inode
> + * @inode2: the second inode
> + *
> + * Return: %true if they are definitely equal, else %false
> + */
> +int fscrypt_have_same_policy(struct inode *inode1, struct inode *inode2)
> +{
> +	union fscrypt_policy policy1, policy2;
> +	int err;
> +
> +	if (!IS_ENCRYPTED(inode1) && !IS_ENCRYPTED(inode2))
> +		return true;
> +	else if (!IS_ENCRYPTED(inode1) || !IS_ENCRYPTED(inode2))
> +		return false;
> +	err = fscrypt_get_policy(inode1, &policy1);
> +	if (err)
> +		return false;
> +	err = fscrypt_get_policy(inode2, &policy2);
> +	if (err)
> +		return false;
> +	return fscrypt_policies_equal(&policy1, &policy2);

You're returning bools here, you should maket his return bool instead of int.
Also you could just do

if (fscrypt_get_policy())
	return false;

Thanks,

Josef
