Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD12500DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHXPX0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgHXPXO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 11:23:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE97C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 08:23:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id t23so10129030ljc.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bfJorIN9utjRTVlveXnOieR763iV4boiYHLMqqDQTJA=;
        b=LFLsvcJCZzfa3gEBse2QeuNwhpKrszDRcLZpDaDzGONLTJ0fbGgoVA09OdYGmp4YS4
         qgd2LOXUIYKee0/bTdFvUP0RoNkX25wW5BMdmrJypm/Q1BZQBPgFZnXvEDuCGuynIHrY
         QrK6gvXR/6WkfWZ8o1/HkaMvNj8T2DPRW4hr7Ac4VmtEMOIM0IQpHgCc3uDWUmj1/fYU
         EatG2ZfKnSuFtlgHdXpILpm7DPMbxWV9+Wc95SnD1znkTonqMdgs+l6/GZRF1Dbt9KJh
         wB6wzHWgpBBwpspHibW0ZJIgujlqHboUGh2rFO5nzFoc49nTOY9fRvzKDupFj0dkgkT1
         nJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bfJorIN9utjRTVlveXnOieR763iV4boiYHLMqqDQTJA=;
        b=mg/xnwVjV3lIaewJ9rN3+BoLxW6l6IAy/cOqfyynaEccX37AktaVOlSDMOiqf/33pV
         GQDdiU+Jk8jjYxjEGpvb9U89UdCwJkNh+JDN930mAss/E77H7MjZKWf/mfxNLf6lJHsM
         NaXBlF7myhOjM8Lj3bmEm6ylmSwvsib7oOCSN0zv2oVlNEXW4Q6LAAVqlrR4Hj9EGV3D
         6/chm8ph5XeUd2kYkUvE85ppuIRKkDvc5w/PfeA5zUW2rYzDUz9nPWCJNTfMaVlGqa8Z
         pnyj3FP/r6q2HwNwikAOiS/kOFyMih2ARQxmugBl6Hd3KPHPW+4be/OPFi0u8lnfFTKk
         jRfg==
X-Gm-Message-State: AOAM533cYEE09RrN/deJaSECoBVWc9P8+6WmPc/dIArJmlOsteIBYk+v
        TnjM+xnpl4ZFfC9SyeeoCBq+7eVg+38=
X-Google-Smtp-Source: ABdhPJwVqhl8p9IQhlRrJSI7J0TKSgLS8VGJkkUv1DstC9aloz9zcYrbdl/J2I/uFH7mdX9V1PRLGg==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr3067447ljg.395.1598282589819;
        Mon, 24 Aug 2020 08:23:09 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:93a3:28ae:5b31:d89a:107? ([2a00:1370:812d:93a3:28ae:5b31:d89a:107])
        by smtp.gmail.com with ESMTPSA id 206sm1574009lfk.60.2020.08.24.08.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 08:23:08 -0700 (PDT)
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Chris Murphy <lists@colorremedies.com>,
        Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com>
 <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com>
 <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUdpQkR4aVJ3d1JCQUMz
 Q045d2R3cFZFcVVHbVNvcUY4dFdWSVQ0UC9iTENTWkxraW5TWjJkcnNibEtwZEc3CngrZ3V4
 d3RzK0xnSThxamYvcTVMYWgxVHdPcXpEdmpIWUoxd2JCYXV4WjAzbkR6U0xVaEQ0TXMxSXNx
 bEl3eVQKTHVtUXM0dmNRZHZMeGpGc0c3MGFEZ2xnVVNCb2d0YUlFc2lZWlhsNFgwajNMOWZW
 c3R1ejQvd1h0d0NnMWNOLwp5di9lQkMwdGtjTTFuc0pYUXJDNUF5OEQvMWFBNXFQdGljTEJw
 bUVCeHFrZjBFTUh1enlyRmxxVncxdFVqWitFCnAyTE1sZW04bWFsUHZmZFpLRVo3MVcxYS9Y
 YlJuOEZFU09wMHRVYTVHd2RvRFhnRXAxQ0pVbitXTHVyUjBLUEQKZjAxRTRqL1BISEFvQUJn
 cnFjT1RjSVZvTnB2MmdOaUJ5U1ZzTkd6RlhUZVkvWWQ2dlFjbGtxakJZT05HTjNyOQpSOGJX
 QS8wWTFqNFhLNjFxam93UmszSXk4c0JnZ00zUG1tTlJVSllncm9lcnBjQXIyYnl6NndUc2Iz
 VTdPelVaCjFMbGdpc2s1UXVtMFJONzdtM0kzN0ZYbEloQ21TRVk3S1pWekdOVzNibHVnTEhj
 ZncvSHVDQjdSMXc1cWlMV0sKSzZlQ1FITCtCWndpVThoWDNkdFRxOWQ3V2hSVzVuc1ZQRWFQ
 cXVkUWZNU2kvVXgxa2JRbVFXNWtjbVY1SUVKdgpjbnBsYm10dmRpQThZWEoyYVdScVlXRnlR
 R2R0WVdsc0xtTnZiVDZJWUFRVEVRSUFJQVVDU1hzNk5RSWJBd1lMCkNRZ0hBd0lFRlFJSUF3
 UVdBZ01CQWg0QkFoZUFBQW9KRUVlaXpMcmFYZmVNTE9ZQW5qNG92cGthK21YTnpJbWUKWUNk
 NUxxVzV0bzhGQUo0dlA0SVcrSWM3ZVlYeENMTTcvem05WU1VVmJyUW5RVzVrY21WNUlFSnZj
 bnBsYm10dgpkaUE4WVhKMmFXUnFZV0Z5UUc1bGQyMWhhV3d1Y25VK2lGNEVFeEVDQUI0RkFr
 SXR5WkFDR3dNR0N3a0lCd01DCkF4VUNBd01XQWdFQ0hnRUNGNEFBQ2drUVI2TE11dHBkOTR4
 ajhnQ2VJbThlK2U0cXhETWpRRXhGYlVMNXdNaWkKWUQwQW9LbUlCUzVIRW9wL1R5UUpkTmc2
 U3Z6VmlQRGR0Q1JCYm1SeVpYa2dRbTl5ZW1WdWEyOTJJRHhoY25acApaR3BoWVhKQWJXRnBi
 QzV5ZFQ2SVhBUVRFUUlBSEFVQ1Bxems4QUliQXdRTEJ3TUNBeFVDQXdNV0FnRUNIZ0VDCkY0
 QUFDZ2tRUjZMTXV0cGQ5NHlEdFFDZ2k5NHJoQXdTMXFqK2ZhampiRE02QmlTN0Irc0FvSi9S
 RG1hN0tyQTEKbkllc2JuS29MY1FMYkpZbHRDUkJibVJ5WldvZ1FtOXljMlZ1YTI5M0lEeGhj
 blpwWkdwaFlYSkFiV0ZwYkM1eQpkVDZJVndRVEVRSUFGd1VDUEdKSERRVUxCd29EQkFNVkF3
 SURGZ0lCQWhlQUFBb0pFRWVpekxyYVhmZU1pcFlBCm9MblllRUJmOGNvV2lud3hUZThEVjBS
 T2J4N1NBS0RFamwzdFFxZEY3MGFQd0lPMmgvM0ZqczJjZnJRbVFXNWsKY21WcElFSnZjbnBs
 Ym10dmRpQThZWEoyYVdScVlXRnlRR2R0WVdsc0xtTnZiVDZJWlFRVEVRSUFKUUliQXdZTApD
 UWdIQXdJR0ZRZ0NDUW9MQkJZQ0F3RUNIZ0VDRjRBRkFsaVdBaVFDR1FFQUNna1FSNkxNdXRw
 ZDk0d0ZHd0NlCk51UW5NRHh2ZS9GbzNFdllJa0FPbit6RTIxY0FuUkNRVFhkMWhUZ2NSSGZw
 QXJFZC9SY2I1K1NjdVFFTkJEeGkKUnlRUUJBQ1F0TUUzM1VIZkZPQ0FwTGtpNGtMRnJJdzE1
 QTVhc3VhMTBqbTVJdCtoeHpJOWpEUjkvYk5FS0RUSwpTY2lIbk03YVJVZ2dMd1R0KzZDWGtN
 eThhbit0VnFHTC9NdkRjNC9SS0tsWnhqMzl4UDd3VlhkdDh5MWNpWTRaCnFxWmYzdG1tU045
 RGxMY1pKSU9UODJEYUpadXZyN1VKN3JMekJGYkFVaDR5UkthTm53QURCd1FBak52TXIvS0IK
 Y0dzVi9VdnhaU20vbWRwdlVQdGN3OXFtYnhDcnFGUW9CNlRtb1o3RjZ3cC9yTDNUa1E1VUVs
 UFJnc0cxMitEawo5R2dSaG5ueFRIQ0ZnTjFxVGlaTlg0WUlGcE5yZDBhdTNXL1hrbzc5TDBj
 NC80OXRlbjVPckZJL3BzeDUzZmhZCnZMWWZrSm5jNjJoOGhpTmVNNmtxWWEveDBCRWRkdTky
 Wkc2SVJnUVlFUUlBQmdVQ1BHSkhKQUFLQ1JCSG9zeTYKMmwzM2pNaGRBSjQ4UDdXRHZLTFFR
 NU1Lbm4yRC9USTMzN3VBL2dDZ241bW52bTRTQmN0YmhhU0JnY2tSbWdTeApmd1E9Cj1nWDEr
 Ci0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
Message-ID: <2aed3d08-94fe-f2ef-e858-31913a8ecfee@gmail.com>
Date:   Mon, 24 Aug 2020 18:23:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

24.08.2020 10:13, Chris Murphy пишет:
> 
> I think we've got a pretty good idea what's going on. The current work
> around in your case will be to use the --luks-discard=true option when
> activating. This will avoid the fallocate step. But the question
> remains why the fallocate fails. I suspect it has something to do with
> shared extents.


Actually I see the same behavior without any shared extent at all.
fallocate attempts to allocate full file size, not just additional
unallocated space:

tw:/mnt # truncate -s $[112*5]M src/file
tw:/mnt # dd if=/dev/urandom of=src/file conv=notrunc,block,sync bs=112M
count=20+2 records in
2+0 records out
234881024 bytes (235 MB, 224 MiB) copied, 1.53186 s, 153 MB/s
tw:/mnt # sync
tw:/mnt # btrfs fi us /mnt
Overall:
    Device size:		   1.00GiB
    Device allocated:		 356.00MiB
    Device unallocated:		 668.00MiB
    Device missing:		     0.00B
    Used:			 224.59MiB
    Free (estimated):		 787.81MiB	(min: 787.81MiB)
    Data ratio:			      1.00
    Metadata ratio:		      1.00
    Global reserve:		   3.25MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,single: Size:344.00MiB, Used:224.19MiB (65.17%)
   /dev/vdc	 344.00MiB

Metadata,single: Size:8.00MiB, Used:400.00KiB (4.88%)
   /dev/vdc	   8.00MiB

System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
   /dev/vdc	   4.00MiB

Unallocated:
   /dev/vdc	 668.00MiB
tw:/mnt # fallocate -l $[112*5]M -n src/file
tw:/mnt # sync
tw:/mnt # btrfs fi us /mnt
Overall:
    Device size:		   1.00GiB
    Device allocated:		 916.00MiB
    Device unallocated:		 108.00MiB
    Device missing:		     0.00B
    Used:			 560.78MiB
    Free (estimated):		 451.62MiB	(min: 451.62MiB)
    Data ratio:			      1.00
    Metadata ratio:		      1.00
    Global reserve:		   3.25MiB	(used: 0.00B)
    Multiple profiles:		        no

Data,single: Size:904.00MiB, Used:560.38MiB (61.99%)
   /dev/vdc	 904.00MiB

Metadata,single: Size:8.00MiB, Used:400.00KiB (4.88%)
   /dev/vdc	   8.00MiB

System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
   /dev/vdc	   4.00MiB

Unallocated:
   /dev/vdc	 108.00MiB
tw:/mnt # btrfs fi du src/file
     Total   Exclusive  Set shared  Filename
 560.00MiB   560.00MiB       0.00B  src/file
tw:/mnt # uname -a
Linux tw.0.2.15 5.8.0-1-default #1 SMP Tue Aug 4 07:30:59 UTC 2020
(9bc0044) x86_64 x86_64 x86_64 GNU/Linux
tw:/mnt #
