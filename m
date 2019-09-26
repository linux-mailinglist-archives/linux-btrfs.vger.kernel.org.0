Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057C2BF148
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 13:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfIZL2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 07:28:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38388 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfIZL2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 07:28:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id u186so1417404qkc.5
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l7KkcgmMAx5Chu65LItnP4PTmJg1HOFj32jcyMccr5g=;
        b=LwruemCKuZIEaKGsIpeh6c7/08l6K5967PSS6zRmMVj22aw1J6SbmUvyj4tPnlSaWt
         +rpIIurcV/Tr7d4hcpd0XCcP6qDCI2LyIiNbLGRFX6WHxkZ9Z8o3K8JsoLkT0tRIe+tV
         vCUWW+HdatmG8gjIQEm7rNnaRfn+hcDyyzSFlbIk9O655ygtmcAhqL/eqVC/y2GVIFax
         ZZu739sRzVsS2QeOXNPZaUF/4tmr8XV/vOTMeImxX/UuR6/NVYUX0aPqnhJkCggVf9VF
         yBePOaEFO1s5BJJufg5OPXMetbyXrK2hRCjkghcUMUkxsbaKZ2dYzPrX9goEo2lMZfLz
         vhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l7KkcgmMAx5Chu65LItnP4PTmJg1HOFj32jcyMccr5g=;
        b=R6JenusjQpbWpBs8tFZfITDWHH0DG1IFGztptbi5T3AayUTgqgaI9lpFFP24HV7hNg
         IhgC15dyskd8aR3IWSZLsXTbKx46viXN0FXyrGWTPq1EhxRt/4xmgHpVRqrUe4eSLaCk
         Zf70Zk4w+nTYLrEsGwR9nCOj1lkC6FvaNERBeOiDblD5MLfLdaCkDlQNt80nVQ9ERTya
         x2NUWMM6aOhl2yWfF251rAPAE2kqoYzNCaxJvktiQooM8PTX++MtpAnvAOkLD8a/IHex
         T0eH/gOxuSooRXZZGfFwMVYVn9XuKlKH8DWZ95StphCAFP2R0baqwyGFJxiSiLEbyPNH
         OVIA==
X-Gm-Message-State: APjAAAUGiSIG7gqvlLzIXzqti1G4oZFmEf9xDCcY+W0953tg8VHDiGXV
        TTDN77WcI5aP3SEQpFllDy1bqQ==
X-Google-Smtp-Source: APXvYqyc1VR+DHiE/X0NAM1UTcq23gwRFmZz4OQE04s704cCXgQrdnJplQ6caGokd4cL/KV1SfpTTg==
X-Received: by 2002:ae9:ea12:: with SMTP id f18mr2740795qkg.204.1569497296578;
        Thu, 26 Sep 2019 04:28:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::cafc])
        by smtp.gmail.com with ESMTPSA id 54sm977043qts.75.2019.09.26.04.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:28:15 -0700 (PDT)
Date:   Thu, 26 Sep 2019 07:28:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use refcount_inc_not_zero in kill_all_nodes
Message-ID: <20190926112813.gsjl3gupdrwt3ifx@macbook-pro-91.dhcp.thefacebook.com>
References: <20190926105427.5978-1-josef@toxicpanda.com>
 <fd4f351d-b02a-d820-c27d-f08b0105ab5e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd4f351d-b02a-d820-c27d-f08b0105ab5e@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 02:13:44PM +0300, Nikolay Borisov wrote:
> 
> 
> On 26.09.19 г. 13:54 ч., Josef Bacik wrote:
> > We hit the following warning while running down a different problem
> > 
> > [ 6197.175850] ------------[ cut here ]------------
> > [ 6197.185082] refcount_t: underflow; use-after-free.
> > [ 6197.194704] WARNING: CPU: 47 PID: 966 at lib/refcount.c:190 refcount_sub_and_test_checked+0x53/0x60
> > [ 6197.521792] Call Trace:
> > [ 6197.526687]  __btrfs_release_delayed_node+0x76/0x1c0
> > [ 6197.536615]  btrfs_kill_all_delayed_nodes+0xec/0x130
> > [ 6197.546532]  ? __btrfs_btree_balance_dirty+0x60/0x60
> > [ 6197.556482]  btrfs_clean_one_deleted_snapshot+0x71/0xd0
> > [ 6197.566910]  cleaner_kthread+0xfa/0x120
> > [ 6197.574573]  kthread+0x111/0x130
> > [ 6197.581022]  ? kthread_create_on_node+0x60/0x60
> > [ 6197.590086]  ret_from_fork+0x1f/0x30
> > [ 6197.597228] ---[ end trace 424bb7ae00509f56 ]---
> > 
> > This is because we're unconditionally grabbing a ref to every node, but
> > there could be nodes with a 0 refcount.  Fix this to instead use
> > refcount_inc_not_zero() and only process the list for the nodes we get a
> > refcount on.
> 
> 
> I'd also add the detail that __btrfs_release_delayed_node actually does
> the refcount_dec_and_test outside of &root->inode_lock which allows this
> scenario.
> 
> And this bug seems rather old, ever since :
> 
> 16cdcec736cd ("btrfs: implement delayed inode items operation")
> 
> 
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/delayed-inode.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 1f7f39b10bd0..320503750896 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -1936,7 +1936,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
> >  {
> >  	u64 inode_id = 0;
> >  	struct btrfs_delayed_node *delayed_nodes[8];
> > -	int i, n;
> > +	int i, n, count;
> >  
> >  	while (1) {
> >  		spin_lock(&root->inode_lock);
> > @@ -1948,13 +1948,16 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
> >  			break;
> >  		}
> >  
> > -		inode_id = delayed_nodes[n - 1]->inode_id + 1;
> > -
> > -		for (i = 0; i < n; i++)
> > -			refcount_inc(&delayed_nodes[i]->refs);
> > +		count = 0;
> > +		for (i = 0; i < n; i++) {
> > +			if (!refcount_inc_not_zero(&delayed_nodes[i]->refs))
> > +				break;
> > +			count++;
> 
> This is buggy, if the very first inode in the gang causes the break
> statement then the code does delayed_nodes[0 - 1]->inode_id. E.g. the
> increment should be before the refcount_inc_not_zero.
> 

Sigh, no patches from me before breakfast.  I'll fix this up after I eat.
Thanks,

Josef
