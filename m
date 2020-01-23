Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A849146A5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 15:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgAWOA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 09:00:57 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35112 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgAWOA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 09:00:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so3504009qka.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 06:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B1Ghg74VcaDGZEjCG1V5UcszEq4lL1H9+cgMnyCH1qE=;
        b=x5yw0S+HqCm+wJ6jljD+RbYUyulgLpXVMDke7cdFy460scYJz2wZ+RsoEzyyUS+cSN
         AsgIleMY0H0T5lRpt2bMBQjUA3CqUE1TqpuyOtPllqidFM9jziVdHm9dk9QINteNFdDq
         uXlbov4dnv+w1xx9W+zW7hhl6ypeLjcLOScfSXdT8WYDY9nhYnCxETAzARaOcB+vEo18
         Wt7JvzmEQOTQicy0oomsmLaoHqcJU8gO0/dzDUGEuXC6vfI2I6j9+khVkArURX4tpU3q
         W4cvyNoxOp9bl5RS/3jRXafz0aOOJirQ7ueqnQgVzVT7qkY/XADE7o4mFIJmPoaU5DzU
         ZnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1Ghg74VcaDGZEjCG1V5UcszEq4lL1H9+cgMnyCH1qE=;
        b=T69b2xTwhms2OzlsqJ72wxs5OYOUXYyOdeWG1CyarkaoAuxotMF2b7pJhm5cmmB4Ca
         xMoxle/5KTywhrR2gsv3LyAQP1+7v+T7mGj46GO2J5Lz+zILJK0t/Gbqgkn9pti3vXFe
         6CWDP+ckZ1nWrQNlDHY7NPep6GIlV6YbfleCWJnNo49IZoDa3Ra3iZolnkqAJ8xyJQYJ
         KCspo4x9MRpRzggY2rr7Y+G/5XQxQ3Xd+7c1Bh5AAVxyKwRg/EGg4+CUP3R7PrkLTilp
         PhMORmUfNYTabqSZtCe5KxKmezoDfboZAAivkfd2m/8g13DuJ8JwORs7VtOieSVKMzLU
         X/mA==
X-Gm-Message-State: APjAAAWFzp+mmPXGjMDajjZpr9+eW2kqEnOuJXjrKc6QFCpqbfJ/oUGH
        r6hrh6e7YxBA1T4DnNasKrvsBtnJvIme/g==
X-Google-Smtp-Source: APXvYqzXMgDIv1SYgGCNEFyZfemGs3mYanH//dRi8NJH+0AWDtK7Ls/uj+L/GwlYTp4pzi6RWJhPKg==
X-Received: by 2002:ae9:e30e:: with SMTP id v14mr15489728qkf.344.1579788055379;
        Thu, 23 Jan 2020 06:00:55 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id a24sm894168qkl.82.2020.01.23.06.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 06:00:50 -0800 (PST)
Subject: Re: [PATCH v2 5/6] btrfs: remove buffer_heads from
 btrfsic_process_written_block()
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-6-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c3564f4c-a062-2ef1-5ca1-98686cc58ca2@toxicpanda.com>
Date:   Thu, 23 Jan 2020 09:00:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123081849.23397-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 3:18 AM, Johannes Thumshirn wrote:
> Now that the last caller of btrfsic_process_written_block() with
> buffer_heads is gone, remove the buffer_head processing path from it as
> well.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
