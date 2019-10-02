Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67025C8A69
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfJBOBp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 10:01:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43313 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJBOBo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 10:01:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so15046988qke.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vhowmgkseytW1pHuL0lgJJtUtqRUC7YPO7Hg/w47jj4=;
        b=f5Z+M3TlEajM14Is5sfbCMdOd2HhlK8i0KmSIAeMyb4aLvRrtXXEXq5FqOgrAJSK2T
         yAbPBmBn+avTkNPz3tQSGYBZSqdBA1rFyoQ2/yLZbskpWBhmDEbQwkiAYWal6vzP86Ow
         2iQ2vPs3n+zVFM/UxyNyxEtgUlpfRJ7DyDfkMi/dr9kSNey+knDX9zA6Mv2iZk0rgo4Y
         pQ6401zA76ug5k1YbtCGXoJJ1TZoHrgVVJlq0A0Fj41rpfwWmnAIkIE7Zidhs10WADig
         X1IIzF5d3wzTBNiyEt/bYkQ0vvZdRmh7iTmvfq9ctSo73YK1oxqsWkibC0TyZxrx03hb
         HsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vhowmgkseytW1pHuL0lgJJtUtqRUC7YPO7Hg/w47jj4=;
        b=ejfuwQEaDIYYUImRkIK50Y8s57x9oKxri4pMQsN38+SoRSye8xGwJy/iOmJC2OnYkH
         Qj9vE5rxhrTuMiSuVhtxNBhPGFnv1biBz+e1dcxiHuT1nwYIcsypm9ORgy1q4fBa3IWd
         8BhynLgcF0KP1/40PMIIZse0KGjJuOTSrbJx0+AX0mR/UglgChWsFr9tOScP5Pv1HtUA
         BqF5inbX5QkodPaaehz0PeinvU61q5Z6OrsDgVy4UtrWqyC4nIsVusyVsAw8imHadD8K
         33oBRwx9C4XVXwcJJmx0fsJsWWM02aXYdVqGl/9bfz6Vwo6BNZy12JOrOMV2HUGvyk0s
         OunA==
X-Gm-Message-State: APjAAAU8liXw+BdRtqwYZhvS447lvc05zR5zu30+cmoT6tmZk0GHlaMG
        g43TWR17kUmIbjR0z19AU5LI5g==
X-Google-Smtp-Source: APXvYqyySH0r+WBQZU52aaYxkrLDrFDZU5I5GNsKBRtrlsSyyLyl/sV/Sqxs9OBHY8uGqLsEPmYAlw==
X-Received: by 2002:a37:6713:: with SMTP id b19mr3658748qkc.301.1570024901663;
        Wed, 02 Oct 2019 07:01:41 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p77sm10127501qke.6.2019.10.02.07.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 07:01:40 -0700 (PDT)
Date:   Wed, 2 Oct 2019 10:01:39 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Btrfs: add a extent ref verify tool (static analysis bug report)
Message-ID: <20191002140138.eug7xvwhlsn5qnby@MacBook-Pro-91.local>
References: <3d1bcdce-16ae-d490-0a68-19d9d9d41d92@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1bcdce-16ae-d490-0a68-19d9d9d41d92@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 02:50:51PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis on linux-next with Coverity has picked up a potential
> issue in file fs/btrfs/ref-verify.c, function process_leaf() in the
> following commit:
> 
> commit fd708b81d972a0714b02a60eb4792fdbf15868c4
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Fri Sep 29 15:43:50 2017 -0400
> 
>     Btrfs: add a extent ref verify tool
> 
> The potential issue is when on the unlikely event when all the items
> contain unknown key.types and so ret is not assigned a value. Since ret
> is not initialized then a garbage value is returned by this function in
> this unlikely scenario.
> 
> In the previous function process_extent_item any unknown key types are
> flagged up as an error and -EINVAL is returned.  I'm unsure if this kind
> of error handling should also be applied to function process_leaf with
> invalid key types too.
> 

Thanks I'll fix this up.  You can run into block group item key types and we
don't care about those, so we just need ret = 0;  Thanks,

Josef
