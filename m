Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC93A2176F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgGGSnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 14:43:14 -0400
Received: from welho-filter3b.welho.com ([83.102.41.29]:36071 "EHLO
        welho-filter3.welho.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728191AbgGGSnN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 14:43:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by welho-filter3.welho.com (Postfix) with ESMTP id B6DAA149AF
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 21:43:10 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from welho-smtp3.welho.com ([IPv6:::ffff:83.102.41.86])
        by localhost (welho-filter3.welho.com [::ffff:83.102.41.25]) (amavisd-new, port 10024)
        with ESMTP id sENw3rcB3rBg for <linux-btrfs@vger.kernel.org>;
        Tue,  7 Jul 2020 21:43:10 +0300 (EEST)
Received: from lanfear.intra.poltsi.fi (212-149-206-122.bb.dnainternet.fi [212.149.206.122])
        by welho-smtp3.welho.com (Postfix) with ESMTP id 77C2F2308
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 21:43:09 +0300 (EEST)
Subject: Re: BTRFS-errors on a 20TB filesystem
To:     linux-btrfs@vger.kernel.org
References: <0bd8aea3d385aa082436775196127f1f@poltsi.fi>
 <f2d396d4-8625-1913-9b1c-2fec1452defa@gmx.com>
 <9a804cbb7406be31f55c68d592fd0bd6@poltsi.fi>
 <960db29cd8aa77fd5b8da998b8f1215b@poltsi.fi>
 <e1beb547-3989-0fdd-b2e4-5491728f7dec@gmx.com>
 <7bfbcd06-f4f8-5946-c5e4-d7c7879cf122@poltsi.fi>
 <446cbb5e-bb18-bb93-ee98-d480730e4508@gmx.com>
From:   =?UTF-8?Q?Paul-Erik_T=c3=b6rr=c3=b6nen?= <poltsi@poltsi.fi>
Message-ID: <974197e0-0dc3-e0c4-6c44-b5fe8b6c6f6d@poltsi.fi>
Date:   Tue, 7 Jul 2020 21:43:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <446cbb5e-bb18-bb93-ee98-d480730e4508@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry for the delay :-/

On 7/7/20 1:58 AM, Qu Wenruo wrote:
> Although still needs some extra dmesg context for the following bytenr:
> - 2627928588288
>    I see no obvious problem around slot 10

$ dmesg | grep 2627928588288
[  595.081488] BTRFS critical (device sdc1): corrupt leaf: root=5 
block=2627928588288 slot=10 ino=11274213 file_offset=454656, extent end 
overflow, have file offset 454656 extent num bytes 18446744073709457408
[  595.081589] BTRFS error (device sdc1): block=2627928588288 read time 
tree block corruption detected

This is repeated several times later on. The only thing preceeding this is:

[  243.295071] BTRFS info (device sdc1): disk space caching is enabled
[  243.295075] BTRFS info (device sdc1): has skinny extents

> - 3154217795584

[  602.597770] BTRFS critical (device sdc1): corrupt leaf: root=5 
block=3154217795584 slot=102 ino=12990328 file_offset=184320, extent end 
overflow, have file offset 184320 extent num bytes 18446744073709395968
[  602.597869] BTRFS error (device sdc1): block=3154217795584 read time 
tree block corruption detected

> - 3154257952768
>    Mentioned slot doesn't exist at all, not sure what happened there

[  603.161394] BTRFS critical (device sdc1): corrupt leaf: root=5 
block=3154257952768 slot=59 ino=13467676 file_offset=262144, extent end 
overflow, have file offset 262144 extent num bytes 18446744073709527040
[  603.168062] BTRFS error (device sdc1): block=3154257952768 read time 
tree block corruption detected

> - 3154259034112
>    The offending slot seems fine

[  603.316595] BTRFS critical (device sdc1): corrupt leaf: root=5 
block=3154259034112 slot=27 ino=14013491 file_offset=102400, extent end 
overflow, have file offset 102400 extent num bytes 18446744073709514752
[  603.323174] BTRFS error (device sdc1): block=3154259034112 read time 
tree block corruption detected

> - 3154291228672
>    I guess the problem is hash mismatch, but can't confirm.

[  602.779540] BTRFS critical (device sdc1): corrupt leaf: root=5 
block=3154291228672 slot=9 ino=13286681 file_offset=204800, extent end 
overflow, have file offset 204800 extent num bytes 18446744073709481984
[  602.786103] BTRFS error (device sdc1): block=3154291228672 read time 
tree block corruption detected

Does this help any?

Poltsi
