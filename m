Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9947A18BAE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgCSPVI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:21:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38885 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgCSPVI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:21:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id h14so3423538qke.5
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GC24I1Eqdbe6U6PobXoclIDwj4HDIcy5KE6ih3Nq8+U=;
        b=XqSm1Z7L92bhF0DDZx9NiYzc6svRE57ayttmWa3GrJhp8QmdiTkCskd0zI4eAfPbC3
         upLKJVposc/CbkUkAxstqaOtnWubBRvgBfnCUbVM4OVltuZduG8j89VeDYn9Rof1gU52
         NXkO4LlycaSZj1Z2CZEkHVl3iQfnC+bNal8xw5HRTsS7na+JpAmL1qVD/beW3hEhegvA
         9GlUDpE4cucntxCmZ18pUcxnWJdK0Dv7zO+TfOe27W2GKYC4gfqOuBUw7CiLS880XxEe
         ojbC2181pyh2vs7paEukSujIQxRqeBHKxoluJuUIcwQ9pUJmXMxTb6kGls0ngJhu/uKZ
         kDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GC24I1Eqdbe6U6PobXoclIDwj4HDIcy5KE6ih3Nq8+U=;
        b=g6Kd/GydjUl56C6c4tGphnjSEeA2y8JHiNvqL5P/hL+u/Xr+hxgP1TLqBKx22aO/Mh
         Qvrn6EWi/1VsPMSuORSZmya1imXD7m88ynUQKSGkJVBVDpm69U2Kb4P7WN59+5mwtFH8
         7ttvP6yOJJDLMuG6mKA6+NNgL+SMNVKds/vUgUqF7b/o9cKr1lIeVpN1KOKBMUuK6tm6
         H3Ms69gKjfvno8SstEdu2Ho+7rgUOFCG37VcOHJ2QhbWdPVVt8gE1orbmi9IsXZPR5dz
         Q1n1gz/Ly+iUGZZSbxDo9uUjo+MrcY2LplybYsHARzvtAn1e2IeIovcR0Irie6xX9ZO0
         Unng==
X-Gm-Message-State: ANhLgQ2fcDLTKOa8I04Y1rGFYaDKW/Stkh4gUI2PABlEoP3VKKCEKe9+
        gngORoanQA6Bcf/LZXOeg5S4a3gocE0=
X-Google-Smtp-Source: ADFU+vsu8+C/Fd24qH5KT0xC4I4W9bnqLnY1DUstbrTIXA7MEg5eddojNOnYfL1E70Ru7TlTMehOBQ==
X-Received: by 2002:a37:9f58:: with SMTP id i85mr3373524qke.196.1584631264817;
        Thu, 19 Mar 2020 08:21:04 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d28sm1735602qkl.99.2020.03.19.08.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:21:04 -0700 (PDT)
Subject: Re: [PATCH RFC 05/39] btrfs: relocation: Add
 backref_cache::pending_edge and backref_cache::useless_node members
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-6-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <268bc378-5f23-cf03-c4ef-24f185c92402@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:21:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-6-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> These two new members will act the same as the existing local lists,
> @useless and @list in build_backref_tree().
> 
> Currently build_backref_tree() is only executed serially, thus moving
> such local list into backref_cache is still safe.
> 
> Also since we're here, use list_first_entry() to replace a lot of
> list_entry() calls after !list_empty().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

