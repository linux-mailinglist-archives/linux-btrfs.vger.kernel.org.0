Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489FE64BD1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiLMTTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiLMTTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:19:24 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A298D264AE
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:19:22 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id e13so2044366vkn.11
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOoGdC8tYog/ChtwgweWvYisD9wDYLImyQl5Oq1O3+c=;
        b=TnHnspwkqH0xOFjMUYLW1fPIM4ZVp0RLntJDrow2vmEvZlJlRR1MgNb+vy725OlSrC
         t7diZNiRxEXSwPxkTsBMw8JFaO1Alg2gQmGiEWYIpzd5YiJL6Yc/0+u2rvBieUGTZQG9
         P9fUAPiZjAbeJy840w2SFXZ71dDvVcAqsd3F3q/BGQym0dbFJX+t8nfwlGxRHVFNuFBM
         8JQySq4ToIgUs2pNcAaUl+2XPPswILRqEookTIH399AqK1ApZNI1XAdXhiN36uxgsgCH
         2fDignJLF8sj4b0lXbZCAxtHVV0uuilxfoY2SVFzYe2glFwwxmo4HaaoKIa/1SquyWhC
         y7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOoGdC8tYog/ChtwgweWvYisD9wDYLImyQl5Oq1O3+c=;
        b=lNeNnYVr44WNYqM7ZJDXKZyvYGJUVfLYyLz16uzXC+JGQHBl3KVTiIQEP439wkycTW
         0t5Ii/6Rem08mZbNFPSVCvw7X714kalesGwq4QMff1IU25BQeML1h2iSQPmOoPE9DP5n
         uQ01ZF8ZkfpXgo+ZIybzyWvhI3cMGNG6TUFXjynOEVT/m/1tQ0JuKBrhlqP8zfT5/R1+
         09XKEvI7DagCUKfUWOpGq/Jcaf25h5/8FFc+2sYgTkab8Q2ylqadGb0XlfMZd0u3nsSr
         mhW+S1kw2cVJ3EuiB9tKfDYX68mFjDir7v+HY9kJuRNMF5qHKVCU2IXZveL6w+UIl/pv
         1yKQ==
X-Gm-Message-State: ANoB5plOg+lfZC9ySpGXqPIWpHLhqLtp4mbHHpT54Ko5rbnftdQhEXay
        GN+tQU0SFMAhu2NZTdhSOKYCcw==
X-Google-Smtp-Source: AA0mqf4fmjg04ZSDnd7yVAgtXBoLR5OO2/XevGCx2Ga7EAlsz+amPUs00gSwJa8yyH6WnPxwADB4AA==
X-Received: by 2002:a1f:a9c6:0:b0:3bc:cf73:98cd with SMTP id s189-20020a1fa9c6000000b003bccf7398cdmr12940540vke.16.1670959161348;
        Tue, 13 Dec 2022 11:19:21 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a401200b006ea7f9d8644sm8643790qko.96.2022.12.13.11.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:19:20 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:19:19 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 15/16] btrfs: lock extent before pages in encoded write
Message-ID: <Y5jQN2tM/26/6iOA@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <b576b57fa84a22b4bf114b15f342de89698a6fd8.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b576b57fa84a22b4bf114b15f342de89698a6fd8.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:33PM -0600, Goldwyn Rodrigues wrote:
> Lock the extent range while performing direct encoded writes, as opposed
> to individual pages.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
