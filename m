Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01472F96C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 01:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbhARAtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 19:49:12 -0500
Received: from fbo-4.mxes.net ([198.205.123.79]:13278 "EHLO fbo-4.mxes.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbhARAtJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 19:49:09 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2021 19:49:08 EST
Received: from smtp-out-3.mxes.net (smtp-out-3.mxes.net [IPv6:2605:d100:2f:10::314])
        by fbi-4.mxes.net (Postfix) with ESMTP id 04FC275990
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 19:39:31 -0500 (EST)
Received: from Customer-MUA (mua.mxes.net [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.mxes.net (Postfix) with ESMTPSA id E212675A14;
        Sun, 17 Jan 2021 19:38:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mxes.net; s=mta;
        t=1610930316; bh=UjwC2zsfcDqa0mib3MV1H0nhlwTVKH7k7DUctXw3XRE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AvkyyypYS27WOAwzl0Mv++7Cyw9M18elxIIVhh3QshGg/aHUZQCJnmnPGzjV0TXom
         1xHMt7ciy4pdLWe5zB9YwgXiQzUtuu5OvDonGuH09wYLyftoNhGK3Os4Gpa8FebhFX
         Z7cIDJ57t+5MGynYyH9+4nyFnPk2vdiMxdV3Mv3Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siru.org; s=default;
        t=1610930316; bh=UjwC2zsfcDqa0mib3MV1H0nhlwTVKH7k7DUctXw3XRE=;
        l=1620; h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=olwKGE/4sSoANcJEv7n39CQZNwr17V5JrSriK9RRrCPhcg/VS49Fflukhm5/cmWnS
         PkvKHzoJTPkVi5ATB1ZEVavbNuXqBASFWrRk1GYqRo24kj26cm3n+OVwKUEvRDdeBE
         Vwl56F+z9yosbM8UC0n1oTRUozqWMkkh8a8lr1O8=
Subject: Fast, SLC SAS SSD's as dm-cache or bcache [Re: NVME experience?]
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
References: <b5ea0996-578e-8584-2cc7-4b8422f75566@cobb.uk.net>
 <20210117195516.GK31381@hungrycats.org>
From:   Andrew Luke Nesbit <andrew@siru.org>
Message-ID: <7cae8893-aa56-7399-f0f0-742547c9780d@siru.org>
Date:   Mon, 18 Jan 2021 00:38:28 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210117195516.GK31381@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Sent-To: <bGludXgtYnRyZnNAdmdlci5rZXJuZWwub3Jn>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Zygo,

Thank you for this fantastic message.  I hope you -- and the rest of the 
list -- doesn't mind my jumping in mid-message...

On 17/01/2021 19:55, Zygo Blaxell wrote:
> You can use a NVME device as a dm-cache or bcache device--the low-latency
> interface is ideal for caching use cases, if you have a suitably fast
> and robust SSD.

I have about 4 enterprise grade HGST SLC 100 GB and SLC 200 GB SAS 
SSD's.  I want to use these as some kind of cache or fast tier for a NAS 
I am building.

**It has been suggested to me that I should use these SLC SAS drives 
with dm-cache, by pairing one of each of four SSD's with a corresponding 
high capacity NAS drive.**

This is for a home NAS so quietness is the major concern.  Putting the 
NAS in our living room is the only practical option _at this point in 
time_ for various reasons.

This is going to be a "pure NAS" and the chassis will be roomy.  For 
example, I already have both the following chassis and I have yet to 
choose one or the other:

-   Supermicro SC 732D4F-903B ( 
https://www.supermicro.com/en/products/chassis/tower/732/SC732D4F-903B )

-   Fractal Define XL R2 ( 
https://www.fractal-design.com/products/cases/define/define-xl-r2/black-pearl/ 
)

I think WD Red or Seagate Ironwolf drives would be best option as they 
run at 5400 RPM and keep vibration lower.  4x 8-14 TB HDD's in mirrored 
pairs (obvioulsy taken the dm-cache pair also into account).

Note to self: Investigate HDD mounting kits to absorb mechanical 
vibration.  Recommendations are welcome!

Any other suggestions would be greatly welcome!!

Andrew
