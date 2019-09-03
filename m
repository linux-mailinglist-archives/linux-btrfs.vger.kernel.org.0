Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03E8A6773
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfICLfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 07:35:06 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:36019 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfICLfG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Sep 2019 07:35:06 -0400
Received: by mail-qt1-f169.google.com with SMTP id o12so7811340qtf.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2019 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=099E4ivkfiDf8RWNBkOrdTmBrZHFwpm83O9Qw/3jDoU=;
        b=oFmBxlBzUMhcXpPGtg7pa35dcUHyRpL7EF+Zk0cU1X8Yqjl5Uru5fbDeT1WTJNyVv6
         Xasr0GS6nCB5ku2C1YPSV9sD4FUi9OxWZ6zht94toft0h1U7BQTLQWcMUHC1dijNA4ll
         FhznCu9/JOz9/KxFsZKS5fbjxUSQZr0spsCdQxsDGSC24WO5ggeO6rm3h0ETTwSYGF6x
         FJH5s8oZiwAnyJ+F2olnYK+Ysb98K5a/ULS+bjMQSzAN4AjnkrpK2aXBsQmt2y5Vtyyp
         K6yntSvbj4wJQTrjRwXueAFjIZXAgv1Iyy6IQHGdZx9xRAH3055Gt7e1QVLmPqxWpS2S
         Ob5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=099E4ivkfiDf8RWNBkOrdTmBrZHFwpm83O9Qw/3jDoU=;
        b=tpUVMMnClC7iQf7A4b2lJbD7kq7duxYFyKOp9GDygOAn2MU+0VqM4rIUA+TobBFSzH
         oyDDRKE2iSXZ1LSDUuo29YbB/X8o6W/4qmax6zvVpIn4cEJaSG7M4r49SmZMqGK+XW2b
         SfVKs269d7vak/en1eEJb/QfqBg2/+sT2YR0u12cb9VO2aSdp3Rg6cnPmqV9pWhX8mnz
         5IjD0lub9Rt2zgJys1iLkYsRSa1NZFuXFIXFPJFmfc+aTzl3Ww8P/786SDPrGh7Eemj1
         hUwg3WFzXRoezbEYGcbMoj+XeLzY/Me2TA/HvFPWhK4D6WqW/9OneAlRLV3auLb0tEcX
         562Q==
X-Gm-Message-State: APjAAAXD6VK3aOZYR7G06wK6HZAX2NWeV0laAkH+fvanR9eqQJ2hAuhP
        hE/Mv6yvzzSGW9CIkoP5xVY=
X-Google-Smtp-Source: APXvYqw6bL6HGSx0FaN5vSPZlKfcZ7f7bxp9bpY1NfBDSinEN8BAn3Z6IJApG0E/K3VJ/Xf6Y7TI7Q==
X-Received: by 2002:a0c:d4d0:: with SMTP id y16mr21152258qvh.191.1567510505460;
        Tue, 03 Sep 2019 04:35:05 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id h10sm4708985qtk.18.2019.09.03.04.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 04:35:04 -0700 (PDT)
Subject: Re: Spare Volume Features
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Sean Greenslade <sean@seangreenslade.com>
References: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
 <CD4A10E4-5342-4F72-862A-3A2C3877EC36@seangreenslade.com>
 <20190901032855.GA5604@coach>
 <6590a3f4-891d-2b22-ed43-4d2def43f290@gmail.com>
 <20190902005201.GA12944@coach>
 <CAJCQCtR7_-vkMR=UHB9m_Hxw1K0dEZh6=5me7PfjH-Lp8f5ZSw@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <20e1a91f-2165-10e3-6183-fbce6dbe1da5@gmail.com>
Date:   Tue, 3 Sep 2019 07:35:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR7_-vkMR=UHB9m_Hxw1K0dEZh6=5me7PfjH-Lp8f5ZSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-01 21:09, Chris Murphy wrote:
> I'm still mostly convinced the policy questions and management should
> be dealt with a btrfsd userspace daemon.
> 
> Btrfs kernel code itself tolerates quite a lot of read and write
> errors, where a userspace service could say, yeah forget that we're
> moving over to the spare.
> 
> Also, that user space daemon could handle the spare device while its
> in spare status. I don't really see why btrfs kernel code needs to
> know about it. It's reserved for Btrfs but isn't used by Btrfs, until
> a policy is triggered. Plausibly one of the policies isn't even device
> failure, but the volume is nearly full. Spares should be assignable to
> multiple Btrfs volumes. And that too can be managed by this
> hypothetical daemon.
Having the kernel know about it means, among other things, that 
switching to actually using the spare when needed is far less likely to 
be delayed by an arbitrarily long time.  Worst case scenario in 
userspace is that the daemon gets paged out, but the executable is on 
the volume it's supposed to be fixing and the volume is in a state that 
it returns read errors until it gets fixed.  In such a case, the volume 
will never get fixed without manual intervention.  Such a situation is 
impossible if it's being handled by the kernel.  This could be mitigated 
by using mlock, but that brings it's own set of issues.
