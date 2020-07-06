Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA84B215673
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgGFLde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgGFLde (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 07:33:34 -0400
X-Greylist: delayed 3139 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jul 2020 04:33:33 PDT
Received: from poltsi.fi (unknown [IPv6:2a02:c207:2033:3479::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA7F0C061794
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 04:33:33 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by poltsi.fi (Postfix) with ESMTP id 2A0366E05F2
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 14:33:33 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poltsi.fi 2A0366E05F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=poltsi.fi; s=default;
        t=1594035213; bh=88jcdWu9c4kWs7n+ZUwW6EIgSBJ3rYsPiBS+pNDt+o0=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=SWHDIqzc7I7px/dyO6HqRyGvpLSRpMdlUgOAD9H7JVBRp95cf0PRohCBirleFEGt2
         HMMFNVKQBbCneDB1FiR3eG5IRmbxVdkUnTSMvyPkaul2+DHmRHGsQ218SkEcmjiCEc
         cNzUllybOb5KZ8SVS+jxvNtjeZ/dfBdMJ4/QuDck=
X-Virus-Scanned: amavisd-new at poltsi.fi
Received: from poltsi.fi ([127.0.0.1])
        by localhost (poltsi.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5LlKMhOMRPKZ for <linux-btrfs@vger.kernel.org>;
        Mon,  6 Jul 2020 14:33:32 +0300 (EEST)
Received: from webmail.poltsi.fi (localhost.localdomain [127.0.0.1])
        by poltsi.fi (Postfix) with ESMTP id 7216E6E032E
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 14:33:32 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poltsi.fi 7216E6E032E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=poltsi.fi; s=default;
        t=1594035212; bh=88jcdWu9c4kWs7n+ZUwW6EIgSBJ3rYsPiBS+pNDt+o0=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=EpWc8SFuEHZ3jbkuhle3SY51/qMTneg7EZijEa21d7Mc97tJca8iCEX8MZQA0dU6T
         C5/0/s2UimpKyC3GwQv1nFRSYr83BCcacOpotGqrPntN4oYIAfJO8iy6hGhj5/E/yL
         3qRadUKxsavyoRbBX5zV4FyA7EJVNe/zqm/mp7uk=
MIME-Version: 1.0
Date:   Mon, 06 Jul 2020 14:33:32 +0300
From:   =?UTF-8?Q?Paul-Erik_T=C3=B6rr=C3=B6nen?= <poltsi@poltsi.fi>
To:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS-errors on a 20TB filesystem
In-Reply-To: <9a804cbb7406be31f55c68d592fd0bd6@poltsi.fi>
References: <0bd8aea3d385aa082436775196127f1f@poltsi.fi>
 <f2d396d4-8625-1913-9b1c-2fec1452defa@gmx.com>
 <9a804cbb7406be31f55c68d592fd0bd6@poltsi.fi>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <960db29cd8aa77fd5b8da998b8f1215b@poltsi.fi>
X-Sender: poltsi@poltsi.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Aand I messed up by sending this to the person only. Sorry for that.

On 2020-07-06 13:55, Qu Wenruo wrote:
> Some older extents are affected by older kernel not handling extents
> length correctly.
> 
> 18446744073709481984 = -69632, which means there is some underflow.
> 
> Recent upstream kernel caught it and reject the whole tree block to
> prevent furhter problem.

Ok, so if I understand this correctly, the issue is essentially created 
by using a new (5.x) kernel, whereas the server was running 3.10 (CentOS 
7.8 version with btrfs-support) -> CentOS 8.2.

> Would you please provide the dump for this bytenr?
> I'm a little interested in this.

I'll provide you the dumps you requested in the evening. Should I email 
them to the list, or directly to you?

> Thanks for your detailed report, this would help us to enhance
> btrfs-progs to fix them.

Glad to be of help.

> For now, you can just mount them with older kernel, find the offending
> inode using the ino number in the dmesg, and delete the offending file.
> With all offending inodes deleted, the fs would come back to normal 
> status.

Ah, well. As mentioned in the previous email, I reinstalled the server 
with CentOS8. Unfortunately RHEL/CentOS8 dropped support for btrfs (as 
well as megaraid_sas), so I will be running this machine on the UEK 
kernel for the forseeable future and planning on replacing/recreating 
the FS on the partition.

Poltsi
