Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F61660F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBTPbG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:31:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32919 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgBTPbG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:31:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so3145161qto.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nnmw0tGtYQqxRyjy+xxbIOE5S8uiG8p2Limc9Tq4QsI=;
        b=CPRsSGPAUtbgnqySLr+rnI6453uc+mKj/Y72WpIhnqviShoLl74TEgdEWva17WTUL1
         gx0KtCfDVg/kfFoM3aU3xh3KP0fSCMQ/Yf7qwIxlytQCTN87TmNCnghQ03pb4NxrF/H1
         an3mecKHDPJ/O0gL+mhjdUou6GMmmaQBVePgCVACNqTryifaMQ3PhrqLyvRKCDTOxnaQ
         ZGJ1XyxE1llR/zubPBkT1o5Fk0sux+5TyvrfUgk03GhwfBnZbWA+toQNWypigI/nbuSU
         +LptlP0cP6jRGcP4ShBb+I6Mh47lZB917UW/HDvb7umFis47wruZ8FxIM4QUEhbmkks3
         /5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nnmw0tGtYQqxRyjy+xxbIOE5S8uiG8p2Limc9Tq4QsI=;
        b=OXAe9YjmgtIkOw/wxNU44VuVcu/Q9A8wZEGaucW4vs0vfu4G6HG4snRQMgSN5WPe6s
         HZGPbgQIEtjjM7X2mg3nHl9cnbk072akD24E2xtTJFUPhueLbVjUPLJkob21vI5mFkOU
         SJh/wyuA5kyV8FogvE+VMpc5r4yHcFHQ9eYLGgRodXPvWY6qVv/A19jVgc2EgvjG8JY3
         7mLEf4KclthodFIoNrz8UYDOQ7/GJr86TDI55u3nKJcKRita0wunvgJMFprVghTEm3iR
         tYCliqsJvVda2qlqyEFPpnOl+CVpy4Md1ARiXpGVoafahf1xr7F5a+9oCky4TaibN4uh
         2PKg==
X-Gm-Message-State: APjAAAXURTx3ZHmB3RVzM8XI54kO6ba6wqO8oTGRqvQAdCKK6RaYQxrJ
        Rijxw1HJWRFbrrVyG3VDZUhXQTEHhFk=
X-Google-Smtp-Source: APXvYqwot6aiZI2yUoirkt9rkstu/U9fw/CLvK0IGidiOXHvJhUR39rSBZBR+KJ+NWm93pH5vsVrug==
X-Received: by 2002:ac8:4085:: with SMTP id p5mr26974541qtl.132.1582212665210;
        Thu, 20 Feb 2020 07:31:05 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u13sm1901487qtg.64.2020.02.20.07.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:31:04 -0800 (PST)
Subject: Re: [PATCH 1/2] btrfs/112: remove some tests for cloning inline
 extents
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200219140627.1641733-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1e900857-d2f5-b02f-07c7-1d81062523ca@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:31:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219140627.1641733-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/20 9:06 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This test case, btrfs/112, tests that some clone operations that have a
> range covering inline extents fail with either -EOPNOTSUPP or -EINVAL.
> These cases were unsupported on btrfs because they used to lead to file
> corruptions and were not trivial to implement.
> 
> But there's now a patchset that adds support for them, and the relevant
> patch of that patchset has the following subject:
> 
>    "Btrfs: implement full reflink support for inline extents"
> 
> So just remove these tests from test case btrfs/112, since this test
> case is about testing only the unsupported reflink operations. A new
> test case that verifies that these cases now work, as long as some other
> new cases, will follow in another patch.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
