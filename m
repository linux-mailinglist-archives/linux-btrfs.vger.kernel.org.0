Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A922DD26
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jul 2020 10:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGZIKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jul 2020 04:10:34 -0400
Received: from mailrelay3-3.pub.mailoutpod1-cph3.one.com ([46.30.212.12]:19047
        "EHLO mailrelay3-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbgGZIKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jul 2020 04:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=lbd0rZqk7P+8HSt1174dkNSOrhqj9aAdmLbZKgRsbtQ=;
        b=IbKcIvTNPvFrMsy4Y8OwaYnlHdoAetLNdj2R3IT1LRw6sRrMel5Y1PH6unrXAAa/kcjbQsn7X5S8G
         fcpU8Zm3Bj2Tgv8hvoHVRJaiDU1oZFtaAp1MvIRCLnvUDjm5az1fA7NIskjg0X5+dXUCWqOf/NvzQZ
         xIJTC9HXmDwELYI2AAv6GRE6KyjDxAh4W6SCOBoqgsvnDgFwkCIKjqBL4h47Flyw6bp6NRYfW4E/ck
         l07zrJ18kSVDdEHxSBgw84fj/PH+lSaDS1HjlDOrbbiiVrsIgbHInQLbyYhw6bjnuP1H4CYJm57FQq
         gvgLW+nqmO168rrgvxNLl8RPJSueFKg==
X-HalOne-Cookie: 81d47d02a79641112febf67a41fac0e5638b66a8
X-HalOne-ID: 796013bf-cf17-11ea-86ea-d0431ea8bb03
Received: from [10.0.88.22] (unknown [98.128.186.72])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 796013bf-cf17-11ea-86ea-d0431ea8bb03;
        Sun, 26 Jul 2020 08:10:31 +0000 (UTC)
Subject: Re: Debugging abysmal write performance with 100% cpu
 kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
 <a370a2bf-25b5-eaa0-a5e5-595c967e82a6@knorrie.org>
From:   A L <mail@lechevalier.se>
Message-ID: <6662c137-862e-0fa8-b147-317c26db99ac@lechevalier.se>
Date:   Sun, 26 Jul 2020 10:10:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a370a2bf-25b5-eaa0-a5e5-595c967e82a6@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Now I have a btrfs receive running for >1.5T of customer garbage...
> Receive cannot stop and resume. So am I going to abort and redo it while
> it's at 75.2GiB 5:57:46 [1.44MiB/s]? Or just sit it out?
>
> Stay tuned for the next episode of Knorrie's btrfs adventures! :)
Always interesting stories :)

Anyways, can you throttle your send|receive by putting mbuffer in 
between? I have myself had quite good success with mbuffer in reducing 
overall I/O, not to mention the ability to limit overall speed.


A
