Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6207422FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 11:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjF2JNE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 05:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjF2JNC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 05:13:02 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A24268A
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 02:12:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 011053FF76;
        Thu, 29 Jun 2023 11:12:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Gg5kJ1x7oSzi; Thu, 29 Jun 2023 11:12:55 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 3AA8E3FC28;
        Thu, 29 Jun 2023 11:12:55 +0200 (CEST)
Received: from [192.168.0.122] (port=58014)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <forza@tnonline.net>)
        id 1qEnhu-000CjW-2Y;
        Thu, 29 Jun 2023 11:12:54 +0200
Message-ID: <d875533b-1607-2c4c-45be-44edd6a38eba@tnonline.net>
Date:   Thu, 29 Jun 2023 11:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: question to btrfs scrub
Content-Language: sv-SE, en-GB
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-06-29 10:26, Bernd Lentes wrote:
> Hi guys,
> 
> i have a BTRFS volume which produces a lot of errors in the syslog.
> Here I got the recommendation to start a “btrfs scrub” on that volume.
> I made an image of that volume (with dd) and started the scrub on that.
> That’s the result:
> 
> ha-idg-1:/mnt/sdc1/ha-idg-1/image # btrfs scrub start -B /mnt/image/
> 
> scrub done for bbcfa007-fb2b-432a-b513-207d5df35a2a
> Scrub started:    Tue Jun 27 20:47:26 2023
> Status:           finished
> Duration:         35:39:48
> Total to scrub:   5.07TiB
> Rate:             40.16MiB/s
> Error summary:    csum=1052
>    Corrected:      0
>    Uncorrectable:  1052
>    Unverified:     0
> ERROR: there are uncorrectable errors
> 
> 1052 checksum errors on a 5TB volume. Is that much, or is that normal ?
> What can I do ?
> Start a btrfs check ? First on the image before on the original ?
> 

Uncorrectable errors means there were some corruptions that Btrfs could 
not correct using a good copy (RAID/DUP profiles). Those corruptions 
could be different things, for example media errors on the disk drive.

Is it just a single disk that you have in this filesystem?

What does smartctl -x /dev/xxx show? Especially look at the table 
containing Uncorrectable_Error_Cnt or Reallocated_Sector_Ct.

You can also issue a drive self-test using `smartctl -t long /dev/xxx`

~F
