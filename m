Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A592A306099
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhA0QJA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhA0P4s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:56:48 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D34C061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:56:08 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e17so1714007qto.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YcocHDGHU3qNItDFIIOMhDhxVK9YUI9YdvkQbYFHmXY=;
        b=gbrnJw7P7qf98u1t0Cclc2VjIswS3yn/go/G60T1a9968HMs2w0gP/Zp5H8PDlWstb
         YYLOn5t6AElBe3U6+DKL/vi3H68p+NrxHXXyM1JvIzfy2NbGKBfABVZhiKYmzfm1Ydjb
         YkXRnzj+6ZjwysnM6GpWzKemLvxa/SbFJpHhFjOZsFiMmRizb+lgYtG9d8CIiuJ5TA70
         +EqZ+C53Xk1sqVXENNicN6ZWXzELPN+sKKEuX0uce2veALNWDjFZkz2zkrKxGjjr1Y2q
         YqMe9nuofbS7uLiLdLKqps1AVn43ukBGiLusAcAwXPK9oIYAVerD2wWVSwuOX0aJnp4e
         vqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YcocHDGHU3qNItDFIIOMhDhxVK9YUI9YdvkQbYFHmXY=;
        b=FnQ1bUtbyKkd+rMuouQw+wO4zJxDjcsKpbObQB2IjpUNBqHZT06GAba5SeH51avR9K
         AW3REVoQrJhIIXeFMExBCsgDhIhRbKBrOaUHRuK2PYjQB2xS8+XSwJZuORxCRcelNZIM
         dkgYcavGQ6xuLY08NlCCZCChyBlfG1GAb9AlvtdkciLT3IQd3eqwxCl0cx6lablVDYym
         JBnGT6n/HO+a+6OoG4pDn8eFmggY99S3mp8RJCrCvTR2UHt1Ds3LZn2tLVTDQG2H/rGv
         /t+l7DZtZQHC7LPG0SQDg5xlu73iKTCfDuJofxNlLNDZtqniRCs0vRu76AqDz3R85F/i
         0Q2Q==
X-Gm-Message-State: AOAM530gFMTaxHSBBbYVPIsiKq0m946NtnHhNBH18WJHGIwlRAZLI2zN
        BJRXiR2QxAY0nFHTkjBnyzUdCG/mw1V4hHMA
X-Google-Smtp-Source: ABdhPJzVO8+gy6gkNNDN2qLWXh/4ISVf00G/Nb33e+YHnI9uUvGToafvXZIJeolSmoH0pJpPBbyLHA==
X-Received: by 2002:ac8:5d0d:: with SMTP id f13mr10046397qtx.317.1611762967493;
        Wed, 27 Jan 2021 07:56:07 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c17sm1443582qka.16.2021.01.27.07.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:56:06 -0800 (PST)
Subject: Re: [PATCH v5 01/18] btrfs: merge PAGE_CLEAR_DIRTY and
 PAGE_SET_WRITEBACK to PAGE_START_WRITEBACK
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8db07e28-839d-e3ae-e295-ff864490aeee@toxicpanda.com>
Date:   Wed, 27 Jan 2021 10:56:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK are two defines used in
> __process_pages_contig(), to let the function know to clear page dirty
> bit and then set page writeback.
> 
> However page writeback and dirty bits are conflicting (at least for
> sector size == PAGE_SIZE case), this means these two have to be always
> updated together.
> 
> This means we can merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK to
> PAGE_START_WRITEBACK.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
