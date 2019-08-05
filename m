Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F067F81F40
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfHEOjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 10:39:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41939 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfHEOjp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 10:39:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so2222530qtj.8
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Aug 2019 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PCaKLc9tla/IeFrgx8E5ezCMt+V5+f8eKKtPctqORTQ=;
        b=ADhh73pWbQ2ZBzI3LzDkhp6jFDV8GlcinAUNf7+DE4uVmzrfldwVHkTwm/uxx6nGiB
         A4HMm1h6i7AdBZZsj0nCqsdeh5zE/Lfd4Vkubi9e3BKgiuTXsOVzoETueEYXozxaGe+0
         R//iWjy+QO/C1y9OHZ8XgfaRzPquse2j4iBVd3G9W6TpMue/KdKdqErJH9rUsTPVoCTH
         LDAfUje0m6hUeks75I8fhoEIC8MG99Rpodlv3jNxsTxIyR7tuDavPaWVeMWbdVHPKrku
         crj3KjOTMJSjCy8rVeNYhhM9OxL0pa3TPJ5tsxCxy5WoiJXYONDhKIoyFujnXeJqnLsc
         r2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PCaKLc9tla/IeFrgx8E5ezCMt+V5+f8eKKtPctqORTQ=;
        b=sERYdXudJWQRIE+fCNDPkQToCxAnDylHHMSVTYwUXMWabSTZowVHew2AdI+ms0uJjz
         RIHTtBsAZ7u6nek0xb8oBd+wfaywbPmQkyhc8jzFjPjHH7W7ASqfUSxeUub/t1cUUu2r
         zbDfRXTQ4irQJlngJ3RyIPM2rMVXinuzUbYC3C4vdeywkKWANAe+r/IfAZxiJrJrJa96
         xLlLhsoT4pd8RdOg3sfS44h5Lp75/w7x7KmDf2TnWJgjmVpZepQYd+QM2E5qKHiUWCn8
         k6wVQtSr+WT7tEZHDdNO/oIGbNXrxrYOht0peoH7sVgq2ViWmAwnW+c///vexJ6G3SN9
         n4Gw==
X-Gm-Message-State: APjAAAXJsjkmzqlhK5G6Z03nyxPvpdIJZ33OGeYJKVWf68KA25sncNOO
        VTpby5FpY+0g57Vr0E3ZoUQ=
X-Google-Smtp-Source: APXvYqyA5VFDtHIBXCaCIWlgBR37UoTb7eIQ2TI1VE2uLWiOaalMNs33k9tdbdW+6bfaVbWE5c4+VQ==
X-Received: by 2002:a05:6214:185:: with SMTP id q5mr108303641qvr.213.1565015984473;
        Mon, 05 Aug 2019 07:39:44 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o17sm33205631qkm.6.2019.08.05.07.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 07:39:43 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:39:42 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs: add an ioctl to force chunk allocation
Message-ID: <20190805143941.kvbb3ksbgrlb2ch6@MacBook-Pro-91.local>
References: <20190805131942.8669-1-josef@toxicpanda.com>
 <da46587e-2471-8971-7c26-6c67720af32d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da46587e-2471-8971-7c26-6c67720af32d@gmx.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 10:14:15PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/8/5 下午9:19, Josef Bacik wrote:
> > In testing block group removal it's sometimes handy to be able to create
> > block groups on demand.  Add an ioctl to allow us to force allocation
> > from userspace.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > v1->v2:
> > - I noticed last week when backporting this that btrfs_chunk_alloc doesn't
> >   figure out the rest of the flags needed for the type.  Use
> >   btrfs_force_chunk_alloc instead so that we get the raid settings for the alloc
> >   type we're using.
> 
> Still not sure if it's worthy to add a debug only ioctl.
> 
> If sysfs is not good enough, maybe modify btrfs_force_chunk_alloc() to
> do extra chunk allocation depending on a internal return value
> overridable function?
> 
> At least for the later case, we can trigger empty chunk allocation with
> BPF while without messing any interface.

I hadn't thought of the sysfs route, I actually like that a lot better.  Once I
figure out why our debugfs stuff is broken I'll add this in there, that'll save
us a btrfs-progs command as well.  Thanks,

Josef
