Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60634B8CF
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Mar 2021 19:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhC0SNx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Mar 2021 14:13:53 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:33846 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhC0SNb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Mar 2021 14:13:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id EAB1F3F5D1;
        Sat, 27 Mar 2021 19:13:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uuJAGUNPcj0o; Sat, 27 Mar 2021 19:13:28 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 3E3133F39B;
        Sat, 27 Mar 2021 19:13:28 +0100 (CET)
Received: from [192.168.0.10] (port=56122)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1lQDR9-0001bn-KS; Sat, 27 Mar 2021 19:13:27 +0100
Subject: Re: APFS and BTRFS
To:     Forrest Aldrich <forrie@gmail.com>, "Eu, acc" <accensi@gmail.com>,
        dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <7ead4392-f4c2-2a5b-c104-ae8be585d49e@gmail.com>
 <20210322222257.GC7604@twin.jikos.cz>
 <CAA+gEba91br_M6qERcwL5no=DdMSw3QA7iNwf8OGwskX=9Z6_g@mail.gmail.com>
 <8aaa32e2-c9bf-ef48-b6ac-1b04b26ab415@gmail.com>
From:   Forza <forza@tnonline.net>
Message-ID: <43aa98ff-edfb-fba8-1bbb-2c497fbbe89e@tnonline.net>
Date:   Sat, 27 Mar 2021 19:13:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8aaa32e2-c9bf-ef48-b6ac-1b04b26ab415@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 2021-03-23 00:19, Forrest Aldrich wrote:
> I have apfs-fuse running, but it is read-only.
> 
> I wanted to avoid the pain of replicating a large disk from USB3 to USB3 
> by converting the filesystem, which I expected wouldn't be possible.  So 
> now I am just replicating it, which will take days to accomplish.
> 
Have you considered taking the disks out of the USB enclosure and 
putting them directly on the SATA controller? It could be faster.


~Forza
