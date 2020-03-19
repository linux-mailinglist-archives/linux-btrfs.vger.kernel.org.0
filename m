Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E697818BDE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 18:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgCSRV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 13:21:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42226 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCSRV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 13:21:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id g16so2492594qtp.9
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JriJaIwWKl1CzA3s16HrcbwSjn+mUxibnGi87EVS6Nw=;
        b=f89ILZaz1cLsuvtvWbTu2lDtKRt484u0416zzheEYiK0QTO7bu9aIMSbdY73vIgzcU
         OQzS7DcN6Wwt7mNZFJHAKMj5rHvnEYgnaxvrp3SS5vSY/u1AMuHbWx8Tv5TQo8Uu+m1m
         Arc++zGzmzeXuQ6gFUuHLkwl/Jf+Js/rVyzLzNDhid4hJavJA7lSN/NyBEJ6p14g83i+
         XV/DqFg1w2cubTMguIoabNAmC+hzmjOPw6J0IZrmtKNlW5QZIjyp9mu8lmLCuY7SGxtB
         dev5HEpwgnW5tpBP4CTtFGMg8uLA2hgBJkQ6DnCETGnDhtuN6BmpJ7u/O63UOc/bIR57
         u5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JriJaIwWKl1CzA3s16HrcbwSjn+mUxibnGi87EVS6Nw=;
        b=jJx5cQIzSGqQf/TjDnsvC75mTbchYUn/MDNGJwBXBvokiMmOLgKJfPhS+oLwPYSTLt
         U3l2jAwkrx9rsn7j1SRhGariNryUIO4vjw/rJIALH2KwzcblZbyQNoNL0cY7dtJJXMlM
         +5c22mXYh6A1y2iuiNZ0PRcFfYz3l98JlrZUVv/z7bS3HWBbpMH/ySJ/ml8+ce4tPsak
         UC0V+D1CEe8zT6KeNE7bU89VZxOxS5aHeDtB6bGXTue9XEZpN+LG9rbCibPNCge+26aA
         AwoAYJivrKXzK0F/2lbvtCmqPLj7nCex0MALUIbSZdzHX3T9tJPI253MtP2W7EZGzNBg
         WFmQ==
X-Gm-Message-State: ANhLgQ2R4ZPxCWY6fEGrE4vkoI5OEKC0Zqpht/f2PXA2+HjjyvunMbid
        HGVtRLh1rKcZFjefCQLin4LlkxfMDUA=
X-Google-Smtp-Source: ADFU+vvHnHSjaacFUnSq83/UdXRdmNAaIvcL6A2RM0xBvjsGAM4nl13lk8EshHf9vNKJgCUrsky3ow==
X-Received: by 2002:aed:3be8:: with SMTP id s37mr4142151qte.129.1584638516793;
        Thu, 19 Mar 2020 10:21:56 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z11sm2018927qti.23.2020.03.19.10.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:21:56 -0700 (PDT)
Subject: Re: [PATCH RFC 14/39] btrfs: relocation: Refactor the useless nodes
 handling into its own function
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-15-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cb837e71-3766-c7fb-8871-bd3423a183e0@toxicpanda.com>
Date:   Thu, 19 Mar 2020 13:21:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-15-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:11 AM, Qu Wenruo wrote:
> This patch will also add some comment for the cleanup up.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
