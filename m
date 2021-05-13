Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2068637F680
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhEMLMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 07:12:50 -0400
Received: from mail-out1.in.tum.de ([131.159.0.8]:45349 "EHLO
        mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231255AbhEMLMk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 07:12:40 -0400
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 90CEF4A0491; Thu, 13 May 2021 13:11:29 +0200 (CEST)
Received: (Authenticated sender: fent)
        by mail.in.tum.de (Postfix) with ESMTPSA id 50A0D4A009C;
        Thu, 13 May 2021 13:11:29 +0200 (CEST)
        (Extended-Queue-bit tech_stoeh@fff.in.tum.de)
Subject: Re: Leaf corruption due to csum range
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de>
 <CAL3q7H7mFmNhhCUTeYG_56gsz1p2G_sN=1GuPBjdbB=sC-EQyw@mail.gmail.com>
 <ad414944-2418-3728-ac1a-5d4d37e37ac1@in.tum.de>
 <CAL3q7H6WmvatgNpGA6pqPBfe6TjPViwwCJo=wrjBOZRN0q0LuQ@mail.gmail.com>
 <ef9ea56e-fb47-f719-137b-ffb545a09db7@in.tum.de>
 <CAL3q7H7xTSbyEBz9vqZc3tnqcccWTxLENLbvSX11LU7JcBXKuA@mail.gmail.com>
 <CAL3q7H4UrNS+3DMWTzo+hueNQ_PhyUQO5pZg34E+EhUXwukBew@mail.gmail.com>
From:   Philipp Fent <fent@in.tum.de>
Message-ID: <a38ea033-56d9-8325-9a7e-0ef630220a97@in.tum.de>
Date:   Thu, 13 May 2021 13:11:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4UrNS+3DMWTzo+hueNQ_PhyUQO5pZg34E+EhUXwukBew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.05.21 12:50, Filipe Manana wrote:
> Ok, never mind.
> I changed the 'sleep 5' to 'sleep 15' in the script and it works now.
> Seems like 5 seconds is too little on this vm for starting the server.

Oh, that timing is unfortunate and sleeping is admittedly a not a good
solution. You can try to add '-l 60' to the first sqlcmd to increase the
login timeout, which should eliminate any unnecessary waiting time.

> I can also trigger the bug. I'll see what causes the bug.
>
> Thanks for providing the reliable reproducer, it's really helpful.

I'm glad this worked! Thank you for taking the time.
