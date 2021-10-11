Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11D34297C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhJKTtq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 15:49:46 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:58546 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234763AbhJKTtn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 15:49:43 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 15:49:42 EDT
Received: from venice.bhome ([78.12.10.152])
        by smtp-17.iol.local with ESMTPA
        id a18ymPJH7UpwUa18ym5PzP; Mon, 11 Oct 2021 21:39:28 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1633981168; bh=XKrNDCcfWHcskFhb51nQHAOyHIjU4BbDk0Rk8Cvm0N0=;
        h=From;
        b=GUAL7/eUcrfM13Tos4EC+l7uJR8yxaVpcuDqRxXLIVIdQ3DARSeqG9KbnuBs7QFYJ
         VSF6IsANfjFPC4rXWL0+6Tzp6AwftTNVM9nWnhhWpe/kXT+hb0/DzateevwXM3D567
         uGtQ6fbgPZcuBP7HQfg25SXOlOAZSauaGW6WIR34JJppYtLE7Qkd9OdWJGqiCLW8JS
         nKtCyrkzTClU/JqueDCNk903InnwLzxQnlHHmgGGBmChSxEo8ig6d6iEK9jtQ2Z0/+
         11zRJIWVN+SdQJ0ShHrQTKKEspEfhybYDTEZknHfvACT3u45H0HHZ7+Owmcyujlpt3
         JybNYtzt5PvhQ==
X-CNFS-Analysis: v=2.4 cv=MJylJOVl c=1 sm=1 tr=0 ts=616492f0 cx=a_exe
 a=EzK6Ev+Ndi4VoAiPDBu8Fw==:117 a=EzK6Ev+Ndi4VoAiPDBu8Fw==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=IqkRf1E5yG1U-Rt8lNMA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v2 00/10] btrfs-progs: mkfs fixes and prep work for extent
 tree v2
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629749291.git.josef@toxicpanda.com>
 <20210825135839.GK3379@twin.jikos.cz>
 <03ae7a36-dbc9-bfad-6ec7-45e929f862a7@libero.it>
 <20211011184716.GT9286@suse.cz>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <a4c31628-0022-334f-e3fa-a546bfd7b08e@inwind.it>
Date:   Mon, 11 Oct 2021 21:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211011184716.GT9286@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJVd0MOJayOSJnMRrQNLrmooekQPeGCzdL8FE/GP73eiF6CxKBmXbvW5Pvl0X+YQy+1mSOWGRIysEbiuqPiJM6j2j716Wzrx7IyEt1HngBTOfxZfMepE
 lxllf8NYWi/Om7cAox+ZCIt233QSkl4kahRQG4DqSxivB8Y7sure4ZitnCKBinMT5OsNAhVlj7XNevQntO/SyNPEs0eHiCmw7mVw7Xb6B3xblfGmM/2kiDvx
 cuGybNdXZrJUs16Nq1c2uBru7G5I45kxyc+RiHlTAKk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/11/21 8:47 PM, David Sterba wrote:
> On Mon, Oct 11, 2021 at 08:35:53PM +0200, Goffredo Baroncelli wrote:
>> On 8/25/21 3:58 PM, David Sterba wrote:
>>> On Mon, Aug 23, 2021 at 04:14:45PM -0400, Josef Bacik wrote:
>> [...]
>>> Even with the "if (EXTENT_TREE_V2)" in place it becomes the
>>> implementation and given that I haven't read the whole design doc for
>>> that I'm worried that once I find time for that and would suggest some
>>> changes the reply would be "no I did it this way, it's implemented,
>>> would require too many changes".
>>
>> Just for curiosity, is there anywhere a design doc for extent tree v2 ?
> 
> https://github.com/btrfs/btrfs-todo/issues/25 but it's more like an
> ongoing discussion than a polished design doc, that's about to be a
> result of that some day.
> 
Thanks, very interesting reading...

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
