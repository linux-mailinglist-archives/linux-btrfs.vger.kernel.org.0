Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6C1501D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 08:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBCHAG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 02:00:06 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:44045 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgBCHAG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 02:00:06 -0500
Received: from [10.137.0.38] (vau38-1-78-245-226-90.fbx.proxad.net [78.245.226.90])
        (Authenticated sender: swami@petaramesh.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B89C2100011;
        Mon,  3 Feb 2020 07:00:03 +0000 (UTC)
Subject: Re: My first attempt to use btrfs failed miserably
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Skibbi <skibbi@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <a9069bcb-73d2-09fa-e156-a1a3037303c5@petaramesh.org>
 <20200202233446.GT13306@hungrycats.org>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <e040719d-c821-a574-0edf-88f64c95da5a@petaramesh.org>
Date:   Mon, 3 Feb 2020 08:00:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202233446.GT13306@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-02-03 00:34, Zygo Blaxell wrote:
>
> Some USB->SATA bridge firmwares are broken, just swap it out with a
> different model and it'll be fine (though it may be difficult to do this
> with a WD Passport drive without taking the drive apart and placing the
> drive in a generic USB drive enclosure).

There are even drives with the USB bridge built-in and no SATA connector 
at all...

> Also watch out for weak power supplies on Raspberry Pi boards.  The CPU
> and memory run at a significantly lower voltage than the USB interface,
> and one symptom of a power supply that is too small or too old is that
> all the USB devices stop working reliably.

This is probably the most important advice. On Raspberry Pis + HDs, weak 
power supplies are the major problem providers.

I happen to have a different device, an HP Pavillion Detachable X2 
(tablet PC-like) on which one of my USB HDs, one I made myself by 
putting a 2"1/2 SATA HD in an USB enclosure, will disconnect everytime I 
try to use it without having the laptop powered by its AC power supply...

It uses BTRFS and gets USB disconnected at first attempt to write or 
remount the FS. But this never damaged the FS.

Kind regards.

-- 

ॐ

Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E

