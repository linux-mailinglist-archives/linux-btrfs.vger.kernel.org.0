Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB8B2FC2C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 22:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbhASVup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 16:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbhASVn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 16:43:56 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92931C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:43:15 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id f26so23458248qka.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/WSkwLRHBqQVIfYfLxy3WCK26kf5FGFyTl+spNhspv8=;
        b=KzVJD2HwHrG2cdFh4DA7PCupbHVYDopItA9Z9o8cxizjtDAMX863DBYGXhoqxruxsn
         +RXVv2+ixt82NsxuAUicMlKbbd153xLaghYHAOdiNoKB7ypamOjV7VRa8Cw3F3whow+N
         6lvpOeEedqW0ieVw6HUgUM8yKe7KQuv2538mZ/k3ZLR9zUhxgf7a+vArP8dq9OEgpx4P
         Dkzew+8Z+pqz2RpXHxbcrrEhWWdETh3PCIAIR7LK7qMsI5+8DDTxt+Ns/kVTMN7l/otN
         WBJyXNjARR9QYOEugebW0+IF9EFLuQpWNwEaJ2B94adFKlQ7u4mLBd2LA2jAXu2vhgtS
         TAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/WSkwLRHBqQVIfYfLxy3WCK26kf5FGFyTl+spNhspv8=;
        b=qTQA1y8wuS7vLp0j9q1vCmMGPMTOq09vyxjVtrP1h5Ja5rxGVyoVag8Hn7d40IPoNM
         Y7ZhdusNjmem2U7wti7fJSvt4Zf3lHUFEEYYYOReJh4OfMRBYMkwhjZjALos9uzdqwe5
         UituiU4OHTGGPtLJR6c6j0BwnrHXx1Haz5HzWz8vkCx+T+Qvi5PmSMcUE7N7/HDDQr5q
         o17ht4WUl90EqARCd1OFlZU4L1tnmZ2S+URPENHRmyhGjVIDdCTmTy/zJtbBM91Ao0Kp
         as2gN/BsW56Ul+6cMnloYsH3HecmkBafupWPc8NSB8J4lmLZFuHWXpQm0GuzVhtHAlCB
         ZDkg==
X-Gm-Message-State: AOAM533ajnFQJgBtAadUPW97+CFKVrmLNyVDxwZJi0OjAue4wd0j9TXu
        5npnckzmUqDxRtO1XChPQ50H5GQes9l1Pok/2Kw=
X-Google-Smtp-Source: ABdhPJzX9RTiWq5tugw47N3zMyhwlgtd9/Y9T68XXiwzO74/Jwz3g31NMt0OgOgSGJm0CSBO/xBWkA==
X-Received: by 2002:a37:6141:: with SMTP id v62mr6440763qkb.500.1611092594530;
        Tue, 19 Jan 2021 13:43:14 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:2a44])
        by smtp.gmail.com with ESMTPSA id q73sm18717qke.16.2021.01.19.13.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:43:13 -0800 (PST)
Subject: Re: [PATCH v4 02/18] btrfs: merge PAGE_CLEAR_DIRTY and
 PAGE_SET_WRITEBACK into PAGE_START_WRITEBACK
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <64e7635d-dc51-acbf-4f65-46bed5187eec@toxicpanda.com>
Date:   Tue, 19 Jan 2021 16:43:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK are two macros used in
> __process_pages_contig(), to inform the function to clear page dirty and
> then set page writeback.
> 
> However page write back and dirty are two conflict status (at least for
> sector size == PAGE_SIZE case), this means those two macros are always
> called together.
> 
> This means we can merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK, into
> one macro, PAGE_START_WRITEBACK.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
