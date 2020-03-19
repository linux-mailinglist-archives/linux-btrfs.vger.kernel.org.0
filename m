Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454DC18BAC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCSPQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:16:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35187 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCSPQZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:16:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id d8so3434786qka.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KmTN5EzWi7wt5kxwI6FbiVlFyuHtlZRq4hrxMIZ8/TY=;
        b=Lcl86X/bji6QS76OHXoArj3IKpM8lCIBO4mhsNBeaTt5kfZdc64Qfce6xMSzb85uQH
         M98eugq/kTrEsjneuJxv7hBszYEegtFjyY7beV4rpU5LeF7ZJ/BgQsJy75Yks/o6iWQZ
         HGqW/6IMXrFSVLf45hGlmpXjMennTwt/tTGSxrN2kBN2qKk+aCkzhXk1sbw7XuAUsIuE
         cGpI3qObbn7y64YDP+xPpaQZDeNKZIupA4IJ0YInd7NKYJXmPjQAO1sadWJfAgItvJ5e
         Z9VGOb+KOKsNBETKzoqTGPGMC6rowc8ekmb1Kaz/wSiPG7DI5YKW+rvelMUstrU2gb/I
         o/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KmTN5EzWi7wt5kxwI6FbiVlFyuHtlZRq4hrxMIZ8/TY=;
        b=c3DNPP8wfbvwceuE1rHh/FmX7N7l8f/hONUtVIknUiZdvF5o7oLpYOpy6I+EtR8FCN
         P3/rWcWLLBYSbY7RPwBIv3egI2crjoV46obvdFO9/BPn+7JlvmfksnYl07Y0nvsHuKjh
         Z9D8+VGJ8jT/k5EzSXg1bWSKY8hCA5lg+WG4sIk4CpakawvW/0ZgCtFrIxpBgPC/3V7E
         nJGYHkd2XhDB7Fm3zmcQazxpIzEuunetZ4KPjlYubyckOrPJhIQO1dUWC8I70a3nOBvx
         sGXBvdozftO1LShVMgVbN/RddA4mxWD129FLh8SWqrQTNcurWa4spnsXh5DkTKYQGURx
         oe7Q==
X-Gm-Message-State: ANhLgQ3KOyA17Bm1vh62B4AwVS86qRBI6GRbQQ0Vc3MBukCaRNOSXe7t
        B/lBqoLpHzjYOFm/NhdCrTqoig==
X-Google-Smtp-Source: ADFU+vvX5TDGf8CfRS8sk9Enb3/mqr1Ka//wttQDc2QQr8ZFEEkMCaYr6J6qdK1p15ZwWuZo7ikohA==
X-Received: by 2002:a37:8781:: with SMTP id j123mr3412627qkd.308.1584630984470;
        Thu, 19 Mar 2020 08:16:24 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b18sm1700603qkl.13.2020.03.19.08.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:16:23 -0700 (PDT)
Subject: Re: [PATCH RFC 03/39] btrfs: relocation: Use btrfs_backref_iter
 infrastructure
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <947dc61b-1053-3e96-d4de-293efa6a0833@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:16:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> In the core function of relocation, build_backref_tree, it needs to
> iterate all backref items of one tree block.
> 
> We don't really want to spend our code and reviewers' time to going
> through tons of supportive code just for the backref walk.
> 
> Use btrfs_backref_iter infrastructure to do the loop.
> 
> The backref items look would be much more easier to read:
> 
> 	ret = btrfs_backref_iter_start(iter, cur->bytenr);
> 	for (; ret == 0; ret = btrfs_backref_iter_next(iter)) {
> 		/* The really important work */
> 	}
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
