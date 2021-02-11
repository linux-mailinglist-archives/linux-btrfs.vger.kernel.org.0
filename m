Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509D431927D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 19:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBKSry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 13:47:54 -0500
Received: from smtp-17.italiaonline.it ([213.209.10.17]:51934 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229531AbhBKSrt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 13:47:49 -0500
Received: from venice.bhome ([78.12.25.19])
        by smtp-17.iol.local with ESMTPA
        id AGzRlzLnElChfAGzRlG9yu; Thu, 11 Feb 2021 19:46:57 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1613069217; bh=e1vj9OiqiS1fwYJk3Uqi3ZQSvObSC4NTRKuLRRbNI6w=;
        h=From;
        b=tuJ4ZOpBlpC2cS/6aThJ7BYmwQduYLlzLTlXdJZ2L8Arqi8Y0Tj3yCp0B2YsmmxkI
         2rn/XsxHCDR7YvFVn/AEZEPElgyhCJ0OeZdVEq9bPeQthhb5Ofr7dGME8DA5X5K9xD
         qoRpzjQV8HJ/qMK3HLrHfhjYXcqCefjzwPA/sYSLSFmIvN9OlbNwZTS0bGbcVnx3TC
         v3lpWeneH1b72u1ZKhP5Ns0sXTnhsjxGjOCuogkacX8WcH8Qq7WqEI6M6wK90+/mE9
         ZrIlSpWfSH42Getqj2+vMqpbRVCV6Lh8HucP7UYLNHL1C2zoMhkAZ7BnmdsqahR00+
         MXeaB1h+LAe8A==
X-CNFS-Analysis: v=2.4 cv=S6McfKgP c=1 sm=1 tr=0 ts=60257ba1 cx=a_exe
 a=cZ/q60u+NbBn6HfapJxCHg==:117 a=cZ/q60u+NbBn6HfapJxCHg==:17
 a=IkcTkHD0fZMA:10 a=MqSeC9ST09_qY2kDvqAA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 4/5] btrfs: add allocation_hint option.
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-5-kreijack@libero.it>
 <415a0a47-ce3d-26f0-b770-156b6e53e4a7@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <ecb74e47-d600-3ac7-7a29-2dc460caa9f2@libero.it>
Date:   Thu, 11 Feb 2021 19:46:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <415a0a47-ce3d-26f0-b770-156b6e53e4a7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOfgwQhgP8QDnGzxPRxzEObSjxO8v7sT+CLIcD1aKLzDE2bN0UoAkKckyTNfVy1xwG49jniDyO2HkqOvT6ICQOySLfOr9s9Sc7A0tHmIeHE9ri7lJGRg
 C+FaVZF+EzbPYMxOdRZkyGWs6k8NhgYh97K3xvmqaCGTCck42ElADQPcEb0G+z4Jk92qlxuDWAawqTYgh/HaPuiWqX1zUuD4JJPog/1flMuGNqLhPWh6ec4G
 1b9gtdGM3EduFxZL2orjTLmzzGklytX91uoRpUDFPI5L1VIdRHmAjhOLHVlzktAN
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/10/21 5:14 PM, Josef Bacik wrote:
> On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Add allocation_hint mount option. This option accepts the following values:
>>
>> - 0 (default):  the chunks allocator ignores the disk hints
>> - 1:            the chunks allocator considers the disk hints
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@winwind.it>
> 
> We don't want an mount option here.  If a user has tagged a block device as METADATA/DATA_ONLY or METADATA_PREFERRED we know they want it.  If we want to add a way to disable the hinting then I think a sysctl option to disable is a reasonable compromise.  Thanks,

The idea was to have a knob to switch off all the logic in case of problem.
When the code will be more tested we can drop this part. For the moment I will move this patch at the end of the series to simplify the "manual" drop.

> 
> Josef

Ciao
Goffredo
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
