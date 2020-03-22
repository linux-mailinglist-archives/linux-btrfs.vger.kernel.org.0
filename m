Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5E18E7A4
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Mar 2020 09:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCVIic (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Mar 2020 04:38:32 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:33790 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726781AbgCVIic (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Mar 2020 04:38:32 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-32.iol.local with ESMTPA
        id Fw7qjt8Wpa1lLFw7qjzuH9; Sun, 22 Mar 2020 09:38:30 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1584866310; bh=EG8UI3m5tnjsLoKfOWl09W0whIS/OgmbK760fenY8KE=;
        h=From;
        b=dMYe/QU9mfDBM9FGhaEHy9aVUmBvzPWV/eNx8cNOcW3FsD+7ZvadjY4n7QZJdxZxi
         oQj/aUDM7g/vIBTtztSb8CCbuqsu+oIRagm19jgvyT/Aa6C/eXCvucVUicq1nyIJC1
         jHodtPhYGd+jgSZ2UeuxGdNpIs64oO3X1GJumpkd2ObCDhFDYY+k2DiequcRG56VLr
         vyCCOx5fXeg0Gc7GIZa9DCZTPwFfATl24zMH1Lv5/gTw1rFzPVHlMEDLYNx9BJ3un+
         x10rS2f/p6TeSGsFh72uUmzIcvyc27rmQFEzag5wXaZr5xsP6bRni3ZupgL0xhA7sg
         JnCVmQgOuAlIQ==
X-CNFS-Analysis: v=2.3 cv=IOJ89TnG c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=ja8vGaT1_-EV0Zbrsq0A:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
From:   Goffredo Baroncelli <kreijack@inwind.it>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
 <20200321232638.GD2693@hungrycats.org>
 <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
Message-ID: <d472962c-c669-3004-7ab4-be65a6ed72ba@inwind.it>
Date:   Sun, 22 Mar 2020 09:38:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBiqobmLAoC1AVGhjycjKbZjm6DGHq+w2bLylr+qJmbeMmnDc6hb4OVcyGilnXbkleuDMPBPeLH14tldRJEMb2zLI8Nfkx8nXpj9rikDhKp2la6R4nS9
 PTBDYzCI5bbF1G1+Nx2TYQ8OAx0eViCqftGSoRAZWIW+U7QJw/g2U20iw8N36XIeZXCTeEyYR9IeNp/+0QTc/vUySZVUJIA7P1jKBMK9B23zy7qxpqIfqYdE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/22/20 9:34 AM, Goffredo Baroncelli wrote:

> 
> To me it seems complicated to
[sorry I push the send button too early]

To me it seems too complicated (and error prone) to derive the target profile from an analysis of the filesystem.

Any thoughts ?
  
BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
