Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A36CB25E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjC0XcO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjC0XcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:32:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510ECC5
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:32:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k2so9988784pll.8
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679959932; x=1682551932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzG4Gg7xIaFW9NxPXDSLRapeOggi9FCFkBSxpmUKMiE=;
        b=1RQxRkrglPTErlI0U/PiFpHVr5ejmrxc/OCGg1hCtIbIzQEPzIoej6lelnQsLX6CJN
         9Ne11OkFXot/OFpO24BTU2NOR7MS4njpY6Xg39tzGib/2x1QZ2AkTtw8U06PFpoAVpZc
         SB+YEmo2RrmJqS4l0dfcT1JZPITpV7qjbEkyEGjfn5pPFjvUIJY/dKngy52nILNPGRzY
         wWIu7d2U490aafBxBaBuoFnIhtDwujXLL0pM68Kh5gf40VN0fHyRduECcaISlzwrxNxC
         f9rU/aoOY5WGX4Txt7+8TpTgqw+vC/u38DzH5972BpvoBnjADwAC1nNhGMtjVPdKth4D
         jNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679959932; x=1682551932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzG4Gg7xIaFW9NxPXDSLRapeOggi9FCFkBSxpmUKMiE=;
        b=j2LWg9QZheZkuiHyEPvygnodIIT73VEpFfi41ko430TC2xPNjZCKX0aH0vCcZgGxwh
         6zC8ZJZ9L4/NnJQW9xo+txYp4XdgfKYHWMMa/CRORvge2oGdOBYzT+J+wKl++FOY9QfQ
         X/UJwoxpUmc56k9CaKS5T9SiYOm0fcBdPRX3Il+UeqeH2htbGMSiIIsSHTVGYdYaVg1H
         9/UIktEb+23twSPPrmV2RvZ8QoqbHdGwMltQboAwkdj7TtS28gqbce8uQw5OLn4t5uc1
         KrtOOsZJ0UYfxoAI5Zj5AE50Fq3GchqhKI27cGfTb80u09UGsKRTYxm/XbCx/VqDZCMJ
         Gh3A==
X-Gm-Message-State: AAQBX9coky4NfcvtRlttK1KYVK4ZdGkaoirUwcIL2cRDJHDsx2gYFap4
        iWdOmIY9elm9kvcsxf8ldO7WVg==
X-Google-Smtp-Source: AKy350buONpdk+qgq/lSLy9K1gTrH1FH/VcbtGhAtCeKl9KQ/R4/YjoRmsUyG3Cf3D2ZOF4V+XZ39g==
X-Received: by 2002:a17:90a:c296:b0:23b:4bce:97de with SMTP id f22-20020a17090ac29600b0023b4bce97demr11502607pjt.4.1679959931763;
        Mon, 27 Mar 2023 16:32:11 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r7-20020a17090a690700b0023d0c2f39f2sm4871282pjj.19.2023.03.27.16.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 16:32:11 -0700 (PDT)
Message-ID: <bfbb5ac8-60f2-2212-1ec4-5baaee7a5765@kernel.dk>
Date:   Mon, 27 Mar 2023 17:32:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 7/7] block: make blkcg_punt_bio_submit optional
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230327004954.728797-1-hch@lst.de>
 <20230327004954.728797-8-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230327004954.728797-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/26/23 6:49 PM, Christoph Hellwig wrote:
> Guard all the code to punt bios to a per-cgroup submission helper by a
> new CONFIG_BLK_CGROUP_PUNT_BIO symbol that is selected by btrfs.
> This way non-btrfs kernel builds don't need to have this code.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


