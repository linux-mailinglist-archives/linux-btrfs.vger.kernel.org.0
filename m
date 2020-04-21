Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECCA1B2351
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgDUJx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 05:53:57 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:48785 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbgDUJx4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 05:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=hvdiuPl0KIHv2INqIIAEKyZp2lS6
        iCXMohdB936WJOg=; b=Rvix9lKbxZ76GRlzsowkAXD1+NRZCwEcTPCwo2VRIy4h
        4rIwDYNeRtMV681t3Q1OnPwjcyEwHxJckDLdqdhkJBXMHAhuu2pDmp4kG+0Cqfks
        bO28oyEI5/zanPyOPyfydz6iDnL5O+L4BbyGpdrFDufRBRINFnpzbgcsLYyut3A=
Received: from localhost (unknown [120.229.255.67])
        by app1 (Coremail) with SMTP id XAUFCgAXHaGhwp5elmElAA--.192S2;
        Tue, 21 Apr 2020 17:53:39 +0800 (CST)
Date:   Tue, 21 Apr 2020 17:53:37 +0800
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     David Sterba <dsterba@suse.cz>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] btrfs: Fix btrfs_block_group refcnt leak
Message-ID: <20200421095337.GA88633@sherlly>
References: <1587361120-83160-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200420224315.GI18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420224315.GI18421@twin.jikos.cz>
X-CM-TRANSID: XAUFCgAXHaGhwp5elmElAA--.192S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JFyxAr4xKw4kWr48Zr4DCFg_yoW8JrWUpr
        WDKayj9r98Kr17ta1xJ3yYv3WFka97Gw18Jrn8CrWxX343X343AFZ2gr15Zryj9F1fAryI
        q3WYvFW5C3ZI9FUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
        0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
        Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1iihUUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 21, 2020 at 12:43:15AM +0200, David Sterba wrote:
> On Mon, Apr 20, 2020 at 01:38:40PM +0800, Xiyu Yang wrote:
> > btrfs_remove_block_group() invokes btrfs_lookup_block_group(), which
> > returns a local reference of the blcok group that contains the given
> > bytenr to "block_group" with increased refcount.
> > 
> > When btrfs_remove_block_group() returns, "block_group" becomes invalid,
> > so the refcount should be decreased to keep refcount balanced.
> > 
> > The reference counting issue happens in several exception handling paths
> > of btrfs_remove_block_group(). When those error scenarios occur such as
> > btrfs_alloc_path() returns NULL, the function forgets to decrease its
> > refcnt increased by btrfs_lookup_block_group() and will cause a refcnt
> > leak.
> > 
> > Fix this issue by jumping to "out_put_group" label and calling
> > btrfs_put_block_group() when those error scenarios occur.
> > 
> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> 
> Thanks for the fix. May I ask if this was found by code inspection or by
> some analysis tool?

Thanks for your advice about the patch! We are looking for some automated ways
to find this kind of bug.

