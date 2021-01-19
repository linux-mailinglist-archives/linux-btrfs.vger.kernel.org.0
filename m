Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4322FC243
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 22:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbhASV0z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 16:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbhASV0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 16:26:12 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060B3C061573
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:25:32 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id h21so917721qvb.8
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zWwDgW9yn6n7N8JN9weOrJu8f65DjKIYKA7LMNgiAfs=;
        b=rFkA9hVaIOZxWdVMB0/bSltwu+ve56nnAz2Qn57LHo35BfRFXyD+hO0Ifq/qZtYspt
         xrCWeGsE1QqnVax+6Qx+R+UZW/aPg0/fGctRbekRztSEkxIcJbZI1IcMcsGO23D2esjc
         mCGIg85pNZVS7kJZUJmUZiHJ3rrJTCFklGBHfe5dvHUTBzsH4tdwsGtCIJT/HIj0mT0c
         RlXKQEMr7v/FNd7XL+FyYtduItrPomIYzIhn5cwrOJeFrzpEwTmeHN72eVjUpX309DTa
         BPG6gviA9UN5+g8kt64NvqSPYOwddAxKtSZwesQoaKTKB6u7ohaD1bB7IjyKM3Vj/Hw9
         iOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zWwDgW9yn6n7N8JN9weOrJu8f65DjKIYKA7LMNgiAfs=;
        b=IvsdpAsi6lYEDgBoWIOPhJVxkAeHwt/cc9R+5GX6xNujVMOp/mLW4qljgiwe+sxLlQ
         Et5i/rQn27iPnhDKZIbW8KFrxeAqgFBdI8s+JeBNhZ/UaIkMMu+rG5ylP0bFiB1dR5N/
         TICS1qmfMXPFy8Xwdw7ueJlBjyFw34RpHNl13o2IhVX0ehpIMTm1ImL/L7o1hFe5fMlC
         QV5yHzSfXudy44HSHgytTKSnptNJ5FOWhs8PicCjnaZTnB67h5fxxT5md/2n/yFkSSQz
         uoP0yCXZGCwmjDOvpkex7iKL992XGXP3+NBGzMnXuW3hvgNVWms84TEU5JAdtP2UXARe
         x/qQ==
X-Gm-Message-State: AOAM532iHiitzeWHAZQokTfy1kwaPykBiTEOKgL2aPRXTf+n5rQO/cD9
        HOF7wImzteUgT5/h3CuViHglquPXKP21kzRfZQI=
X-Google-Smtp-Source: ABdhPJye5GwxbxpJYFhm/8afPwlulRTs8gGTx2XvQSrRaewasraKy8Xo6MJVCewLTsK9QaE6c8dOKA==
X-Received: by 2002:ad4:4f4a:: with SMTP id eu10mr6479359qvb.17.1611091530937;
        Tue, 19 Jan 2021 13:25:30 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:2a44])
        by smtp.gmail.com with ESMTPSA id 6sm13790406qko.3.2021.01.19.13.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:25:30 -0800 (PST)
Subject: Re: [PATCH 01/13] btrfs: Document modified paramater of
 add_extent_mapping
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210119122649.187778-1-nborisov@suse.com>
 <20210119122649.187778-2-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d535c9cd-6298-dd38-0725-4ae199e73de6@toxicpanda.com>
Date:   Tue, 19 Jan 2021 16:25:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119122649.187778-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/19/21 7:26 AM, Nikolay Borisov wrote:
> Fixes fs/btrfs/extent_map.c:399: warning: Function parameter or member
> 'modified' not described in 'add_extent_mapping'
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Subject should be 'parameter'.  Thanks,

Josef
