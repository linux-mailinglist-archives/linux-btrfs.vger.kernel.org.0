Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0625048B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHXREQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHXRC6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 13:02:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7DC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:02:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so8054040qkn.4
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tMKFUNEhFl/SU/4aB9YfSb/wgnoa3EcBYpVlIMiCjmw=;
        b=PMNp6iyUi7m89IJ7Cwf3CdRsXL5Kq3KbkxOuvahr2MlG4CBQi4CN3MahxGFN2zt7/a
         tr8uklkmHx+na5y+tCTKizSw7i7dw2MFwHpjGdcrb7kHtAp5gxpVP6+WppFrb+xTjyba
         tgD807JSAU8rKqxpPeWt5wU+kw1ddUDC529grPsNknwKShVhc5aXw7Wp1nZZDT9LtinB
         9FeF4R8x4xXCyD2pSjYbjsFWqbkJb0FPvm01yPpGz8KrTc9rH+nd5B5mCSODBDf5EXzK
         upygSAGyolOrqaDlukeCTmzJ2yW4Jc5BRZWI9nnMRAvmicT9z+Ns1rezB5DZjArHTyD4
         yhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tMKFUNEhFl/SU/4aB9YfSb/wgnoa3EcBYpVlIMiCjmw=;
        b=Jmoe3+B7O3ei3tnb8/XkTucB6sO9nENGBoZfvO58eqWYU39oVWpujKM8VlQOdQRazy
         IMlwViuhrUwqyi94ky31eF9nvQPh7TzZaduJvWmlIpw+LTv/lbuVD3zgXFuwJDu3IAUP
         GDmlPEcva8lfuYT2wcjsW2TZaZi/y4MAbK0MNDdaTc6Upn5qYZe97te+vYv6EHM1crDQ
         hVjnTHWVk3rgT0eTMVQYOhjB4vugWt8t0ud8PuQOm1Pu8SDJpFOsTzVej9OPMTN3qooy
         M1V+OB4JeuvpCFf/Gt7aTPZLncYGIVy0G66Pph1iDCi1AKZ9QYTd5GkOkxxuJy7w+b0A
         O4gg==
X-Gm-Message-State: AOAM533Wwu8/SJnNyckU5qCQHIRQjtx3In4BmPc/OGiFYOrqar3SGn5n
        Op9Kb1C/ZhNf6KqQ5YZx2xtJtxcsA3K+NQHy
X-Google-Smtp-Source: ABdhPJxYOeWEXR78yTBqqVu65RdEiOr5sfdAQi6EHzf8BJ5C+N6Qr3nmO1xtmLtBSFulRUDqNyThWw==
X-Received: by 2002:a05:620a:6c7:: with SMTP id 7mr5149909qky.30.1598288572109;
        Mon, 24 Aug 2020 10:02:52 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 198sm4237606qkh.19.2020.08.24.10.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:02:51 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] btrfs: remove the again: tag in
 process_one_batch()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200824075959.85212-1-wqu@suse.com>
 <20200824075959.85212-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bffc98ac-b42c-9598-96b4-7a54a54668b4@toxicpanda.com>
Date:   Mon, 24 Aug 2020 13:02:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824075959.85212-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/20 3:59 AM, Qu Wenruo wrote:
> The again: tag here is for us to retry when we failed to lock extent
> range, which is only used once.
> 
> Instead of the open tag, integrate prepare_pages() and
> lock_and_cleanup_extent_if_need() into lock_pages_and_extent(), and do
> the retry inside the function.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
