Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2963B9A6B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 03:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhGBBJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 21:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234370AbhGBBJl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 21:09:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17A7A61410;
        Fri,  2 Jul 2021 01:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625188030;
        bh=UjT3wKYrLIDYj2zGG8oqyyOctj0jABvrNaQw+gkvs7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UvxIIjmOMyWNt+pT8ioppOG4hwLTvTKy73f+VdJabAMR4QY/DrLG6Pt0laWUmpz3w
         GZHjrvWFqtkywEfQ1Rfo1Oa5UKejckKRKjrtr/o43Gmz71aKPPIn9hH8kzbFFhv1b1
         p8k8XxV+4TkWwyylF7CnGvbh9q+VyddwzWpYqL6Qv25Mz7+3v4/om8AwsJEB9boNLP
         RnkKUa/YOAY2KYZd7vf495qVPchwSJjMt6sw0kxbS8uhd3jOMRiCGvbqZ6rA1jbL7S
         +LmSCju694IqHpYVl64Lh9qqRjDRIm+EJNQiyJUCy8DKkc5LR95vGnRCfsW7RzwUjN
         RYTgAWydx3neA==
Date:   Thu, 1 Jul 2021 20:09:03 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
Message-ID: <20210702010903.GA83901@embeddedor>
References: <20210701160039.12518-1-dsterba@suse.com>
 <20210701215740.GA12099@embeddedor>
 <fc90ec53-1632-e796-3bf0-f46c5df790bb@gmx.com>
 <dd4346f9-bc3d-b12f-3b32-1e1ecabb5b8b@embeddedor.com>
 <62ec2948-77a3-6e50-7940-8de259b8671f@gmx.com>
 <20210702003936.GA13456@embeddedor>
 <77ce2806-9be0-6ed7-4657-a0ce8b3ab0c6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ce2806-9be0-6ed7-4657-a0ce8b3ab0c6@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 02, 2021 at 08:39:06AM +0800, Qu Wenruo wrote:
> > Do you think there is any other place where we should update
> > the total size for extent_buffer?
> 
> Nope, that should be enough.

Awesome. :)

Here is the proper patch:

https://lore.kernel.org/linux-btrfs/20210702010653.GA84106@embeddedor/

Thanks, Qu.
--
Gustavo
