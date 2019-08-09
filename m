Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A711187E04
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407297AbfHIPa7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 11:30:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34312 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfHIPa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 11:30:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id z16so2120072qka.1
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2019 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yvr8idENBW2emFoVNNFe980mGPTQzfpMeJNg5ORqEpY=;
        b=dAyKM8sxkABjnZdhUk4VQqKmG9OQFsRuR0HATTq3JIq0LwVc7513szj7JPrGc2uZp5
         zNmtaNUzpAnIPM+w00FXTPsAVYffMHx24gdE2cYiF6ZQMCVH1Asq7C5NPSP1M5m8/ILn
         u3pwiZpoaxEdxwqAnODyUNtzpo8KjGAj9slnhDRAQJRkFJiSNy1mJhcaA7+10z9AC9k+
         d+km1ZG7B30Yw9IKS1xaq3941CwKn7hOqrIcpRBbc8uNZQ2d7zMujXW+hwTgdqYzvPt+
         YRG5wcSS7H9ibh5y/8AAt8E3MRDeDuOxCFGSo9tj6LRXevDEYF/KN2oIKMDdX9BydcyV
         xIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yvr8idENBW2emFoVNNFe980mGPTQzfpMeJNg5ORqEpY=;
        b=FeVb56jW+oAouqQAnqFgmLoZeWHDAuoRbGjnQvHJxb6zx4bbFyclKYUUm4Qbrx3F/r
         PB+5BqcWUPK7VoW9g6MiJglbZEEyNyzKbvCdgxfY3RjwdeW5SCnhcAk+sDZsb+tA8MQq
         5XCYtRZVF6wFgkP5Y2FMgTccCZGgMKmt5uDpwSGES+x6ZdwnxdoGDCUALLDQeevpbFxx
         TNs5qRgi8AKPeIWFolLZaWvtWkOCf/nITxs2H9crbThbQFeSLXpYY7kVpaggvkHwjIu9
         kTLzkMGyYZeL7JNKLo60UuDTf5kTQnF4+nRu5Dc+bc62a4UXZpUk7hyxEUavqPdS9IKj
         6Mbg==
X-Gm-Message-State: APjAAAW3K01yydTC+CdutrcplmRT2cYIVMIMdPbP+YM65hW+eT5Omtnw
        rMv7pOiu4oMUju9Wvm3hMrRWIQ==
X-Google-Smtp-Source: APXvYqwf+1tIGoG9d4tD4PWniCRe5kioRM37zjWzix4BJ7W1Y7/lmffOsAoD6++TlGo4iz/I49ZU4w==
X-Received: by 2002:a37:a389:: with SMTP id m131mr19107398qke.168.1565364658321;
        Fri, 09 Aug 2019 08:30:58 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c74sm43475153qke.128.2019.08.09.08.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:30:57 -0700 (PDT)
Date:   Fri, 9 Aug 2019 11:30:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: don't check nbytes on unlinked files
Message-ID: <20190809153055.k2eoybu7h4sis2pt@MacBook-Pro-91.local>
References: <20190809131831.26370-1-josef@toxicpanda.com>
 <b48e52c5-46dd-17c6-e9ba-a933f3b83dda@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b48e52c5-46dd-17c6-e9ba-a933f3b83dda@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 09, 2019 at 06:27:14PM +0300, Nikolay Borisov wrote:
> 
> 
> On 9.08.19 г. 16:18 ч., Josef Bacik wrote:
> > We don't update the inode when evicting it, so the nbytes will be wrong
> > in between transaction commits.  This isn't a problem, stop complaining
> > about it to make generic/269 stop randomly failing.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> We shouldn't be able to see unlinked files in the tree. At the very
> least they should be orphans, no ? So why do we need this check ?
> 

Because we don't update the inode when evicting it.  btrfsck doesn't skip inodes
that have orphan items, it just does it's normal checks, which is why we need
this.  Thanks,

Josef
