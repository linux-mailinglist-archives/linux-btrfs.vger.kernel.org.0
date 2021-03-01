Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE2328813
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 18:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhCARcl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 12:32:41 -0500
Received: from mail.knebb.de ([188.68.42.176]:58586 "EHLO mail.knebb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238458AbhCAR2W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 12:28:22 -0500
Received: by mail.knebb.de (Postfix, from userid 121)
        id B165FE358F; Mon,  1 Mar 2021 18:27:32 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on netcup.knebb.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=1.7 tests=ALL_TRUSTED,NICE_REPLY_A
        autolearn=ham autolearn_force=no version=3.4.2
Received: from [192.168.9.194] (p5de00be0.dip0.t-ipconnect.de [93.224.11.224])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cvoelker)
        by mail.knebb.de (Postfix) with ESMTPSA id 406C4E0C20
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Mar 2021 18:27:32 +0100 (CET)
Subject: Re: Adding Device Fails - Why?
From:   =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>
To:     linux-btrfs@vger.kernel.org
References: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
Message-ID: <4744a69e-0adb-7cad-577e-7f17741519be@knebb.de>
Date:   Mon, 1 Mar 2021 18:24:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <36a13b99-7003-d114-568d-6c03b66190b2@knebb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

just a little update on the issue.

As soon as I omit the encryption part I can easily add the device to the 
btrfs filesystem. It does not matter if the crypted device is on top of 
DRBD or directly on the /dev/sdc. In both cases btrs refuses to add the 
device when a luks-encrypted device is on top.

In case I am swapping my setup (drbd on top of encryption) and add the 
drbd device to btrfs it works without any issues.

However, I prefer the other way round- and as the other two btrfs 
devices are both encryption on top of drbd it should work...

It appears it does not like to add a third device-mapper device...

Let me know how I can help in debugging. If i have some time I will 
setup a machine trying to reproduce this.

any ideas otherwise? Let me know!

Thanks!

/KNEBB

