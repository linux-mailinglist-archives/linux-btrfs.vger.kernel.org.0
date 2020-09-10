Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0F26516C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 22:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgIJOty (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgIJOsf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:48:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB5AC061796
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:48:34 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n18so5047044qtw.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MXX94Xt6jNdg/3E5Jq7BNWh8hxGCyja1qmezsYhQhww=;
        b=xD4OeuHPEPBGOpgM3k4pW2dF7ZXwQSODnHZpajJGgsXVsZhb6J58krm3vTJ9oIfwnv
         riPrit9l2UWe6UiqMYkjs14wNGC0s2935DsaXJeXBpV70vO/Hw5hwV8zZCkBmOBNvGki
         1HykYXvUfUukN9Yj5Z4dnRWMgAJtmj9VVlrV+MC0bpADlLEB3Gbaxioy5M+eS0RiV9ZD
         kBsm0N2TOMCQ2862+k4ONb8kWgykXLvvO578pSzu5qQRIIJfWt/HQC99TgAII/dopF1k
         p4Ms2WL+aT+QMt3jsFMLAXsGcLi963mehpwP4XqAY+dLmGVJbXpeqZsoffhAuc6VLFP6
         /xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXX94Xt6jNdg/3E5Jq7BNWh8hxGCyja1qmezsYhQhww=;
        b=tr8CXtc6ttfolVBRlMM7KlWc7LLehWkGSyT4nlEvfc8IfRi112hxFfpvX5GesSrkq9
         oWRv0RszUkm+4CMCpdnZdfOENKe0PYTMup5LUQN1L0fMz7XLzBsxJwMSVCbdWLc1Q3fH
         72GSDaU8pb22ja/b2h5lJ40vmrA42Sbar6fTwLuyAIbtUPrfWakoLvPtnZJYF739Bs9f
         vV6OTn04BQj500Or5x4R1Y5FHP/Y4+ytLlIGAodLmZ8ex0gwe1UrwoT1qWLyt6WFs6o8
         AF2RBRKr0lI24GSPO17Cq1e3lpZePBSSiREZ8KBsBRlIbci/fTbpE8vkg7hF+id/KpIS
         SVJg==
X-Gm-Message-State: AOAM531atkAnzcvxg2qVRBAr9DMtIIHyjMrYoJDPr+43DvnBRoPhr7CK
        BX1csSlla6C6//4T4OaOwMFTBP8QfpexmcZC
X-Google-Smtp-Source: ABdhPJwjclmuqtAogvg5bQEl60c9oSxH8kfMuiXcj8enPGmfgojbd89LN1kkqzgDyjyihABX/SsWSQ==
X-Received: by 2002:ac8:48ca:: with SMTP id l10mr8209097qtr.385.1599749313923;
        Thu, 10 Sep 2020 07:48:33 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j1sm7410919qtk.91.2020.09.10.07.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:48:33 -0700 (PDT)
Subject: Re: [PATCH 2/5] btrfs: remove item_size member of struct
 btrfs_clone_extent_info
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
 <6b02195ffe4787d75f5117b3d8d1c42c5462734d.1599560101.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f762fe0a-bdf3-7f04-e01e-dbe42af0e816@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:48:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6b02195ffe4787d75f5117b3d8d1c42c5462734d.1599560101.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/8/20 6:27 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The value of item_size of struct btrfs_clone_extent_info is always set to
> the size of a non-inline file extent item, and in fact the infratructure
> that uses this structure (btrfs_punch_hole_range()) does not work with
> inline file extents at all (and it is not supposed to).
> 
> So just remove that field from the structure and use directly
> sizeof(struct btrfs_file_extent_item) instead. Also assert that the
> file extent type is not inline at btrfs_insert_clone_extent().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
