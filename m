Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD919FA99
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgDFQnJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 12:43:09 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:36802 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729445AbgDFQnJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 12:43:09 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id LUq0jHXpdMAUpLUq1jXbjt; Mon, 06 Apr 2020 18:43:05 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1586191385; bh=0vDfdNjzLEarT9+IYNzGZXlP4Xxfslmv+Y+S/OuxlT8=;
        h=From;
        b=WCiboZqKyatmDubGXCq14EDsgnTh8xRrvxe5tmlLLCOaVtClb7qUC7F3rujkrreEA
         8RS/RTjOb5xSrBfsv6ltROe2InnR35fW7624NgGKlSoppS/Nk36x2mTtD3GW2YP+yT
         5Q7ApwgnvNVUid0sQZzBtdIFOw6S29c1XchJgDKXRuMgpwhIoRmcSpMtVDSrDCK5iv
         xsiSAyKz51miGKIpXklHSiGKMyh/uYRS/yWn80oW9z9gOogEdjpasVQcNbO3tpHo9w
         hg/85BZ8735rDfANOliuN+XeIl6xUoXL99rkdItFrbTgnAqTW2VuDfb4pmr4aNHfYm
         oyrgQqnwIUc/A==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=gyxUEgA9x9P_OGeTqXEA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
References: <20200405082636.18016-1-kreijack@libero.it>
 <58e315a1-0307-9a26-8fb4-fd5220c1d5a6@cobb.uk.net>
 <20200406022441.GM13306@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <69396573-b5b3-b349-06f5-f5b74eb9720d@libero.it>
Date:   Mon, 6 Apr 2020 18:43:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406022441.GM13306@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKGIqZB1vJShMxNVz4JeJQMvEkw4WcFo4e103WDtGA7zK/JhJDzTpMfCHTqEwkm5zWM2iRc2qSyoADug+Vc2Rc/fBQWf4AkAHkxMHPDZ9ptGYamU/MFB
 s3GXsqKNPvaaEInOCktgRd3gcixvbDVrvVYEFbeuGUAVEKONj55KbJa2USxfZzbH4GToLr5lCDhZg44wuEM2T6oGrWIfqtjlsMQ9qTObh+OlLHwlJiAGjOj0
 uWWfRivWR5M6zWNfZb5unA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/6/20 4:24 AM, Zygo Blaxell wrote:
>>> Of course btrfs is slower than ext4 when a lot of sync/flush are involved. Using
>>> apt on a rotational was a dramatic experience. And IMHO  this should be replaced
>>> by using the btrfs snapshot capabilities. But this is another (not easy) story.
> flushoncommit and eatmydata work reasonably well...once you patch out the
> noise warnings from fs-writeback.
> 

You wrote flushoncommit, but did you mean "noflushoncommit" ?

Regarding eatmydata, I used it too. However I was never happy. Below my script:
----------------------------------
ghigo@venice:/etc/apt/apt.conf.d$ cat 10btrfs.conf

DPkg::Pre-Invoke {"bash /var/btrfs/btrfs-apt.sh snapshot";};
DPkg::Post-Invoke {"bash /var/btrfs/btrfs-apt.sh clean";};
Dpkg::options {"--force-unsafe-io";};
---------------------------------
ghigo@venice:/etc/apt/apt.conf.d$ cat /var/btrfs/btrfs-apt.sh

btrfsroot=/var/btrfs/debian
btrfsrollback=/var/btrfs/debian-rollback


do_snapshot() {
	if [ -d "$btrfsrollback" ]; then
		btrfs subvolume delete "$btrfsrollback"
	fi

	i=20
	while [ $i -gt 0 -a -d "$btrfsrollback" ]; do
		i=$(( $i + 1 ))
		sleep 0.1
	done
	if [ $i -eq 0 ]; then
		exit 100
	fi

	btrfs subvolume snapshot "$btrfsroot" "$btrfsrollback"
	
}

do_removerollback() {
	if [ -d "$btrfsrollback" ]; then
		btrfs subvolume delete "$btrfsrollback"
	fi
}

if [ "$1" = "snapshot" ]; then
	do_snapshot
elif [ "$1" = "clean" ]; then
	do_removerollback
else
	echo "usage: $0  snapshot|clean"
fi
--------------------------------------------------------------

Suggestion are welcome how detect automatically where is mount the btrfs root (subvolume=/) and  my root subvolume name (debian in my case). So I will avoid to wrote directly in my script.

BR
G.Baroncelli
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
