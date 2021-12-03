Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FDD467DB0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 20:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbhLCTDx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 14:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbhLCTDv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 14:03:51 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD2C061353
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 11:00:26 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id q14so4295189qtx.10
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 11:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nNm0E1dt53Ys7eEguh/q8bEyr1mEBHtvIgKGK0oVRpY=;
        b=SpkI4kI6N8ncRG6uGFFEMd+qUpz0YQIpr/i1gxplbdvaLIBPoZE793VSZo2TzRMDdm
         C1Tw3RoM0AWPZXCFleFN9RRcHd0k/VymMYnBrQXZmjeaPuZ5WYPTryOK50rnlbY+33Bn
         OMx/XbbtxA1hc2lu74RHQT6eUsfkJSpG6F4WH8qB3Wz7EEG9UuVWncd5oOcwbCYTuXzl
         9kETy2VHot9AXQ30B/Scl0gF8uxGLIbsL27dJ0lLAEnFR2LlkpXxmwZtDuwMr/8VjMSG
         dcoj+KbeDmN/fQ5Pox6QLAm5hgHr5CU61B+Ki4OazMOhQxPZFooWOJXByYnPuyRy8u+r
         HlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nNm0E1dt53Ys7eEguh/q8bEyr1mEBHtvIgKGK0oVRpY=;
        b=miiVrLvYFlEtmZTClV1o0GnK+e9TVYaF2R3doa70awUy0KIvooNQ84mwnTWvHmEPHi
         Kp0K1H4bCtwwbVoHrX/Zwrsi/vLnpyBHRxeVGM1AFjTe9C7KGj7I5TJ5Fheb5lMFEH1K
         X9PGQgX28GfFkfOdWPDgMUxZKZGxwAnPS0lKPofoXXX+dR1f3m/PECx/O5qOqLiwvU1N
         LRGfmv+2yPlhUY700BIhchn43aHWSP961KzYwc2CYJul3Oiz/rFtbllO/VaNA8OYl4Ma
         rZyx3UbawDNKELUrxON5w22E92mw1TMJTm8Z/lrSB8tR4ybJg9aefK7HH5/YX/J1mi/M
         uoOA==
X-Gm-Message-State: AOAM531tOCVTGjPeNz0G0ICgDU2ceUB7lda8S3NIicLcB/CLfS6GHqwK
        4nSvq5l7/FWbOUQMU2S3IOQ32Q==
X-Google-Smtp-Source: ABdhPJzEkUoIManrmiZjKkIiA+0JcqpCS+WOoRqMcUAayKATbICFoKkPCbsKuUqmEBZUYq3WwIGMxQ==
X-Received: by 2002:a05:622a:407:: with SMTP id n7mr23121199qtx.601.1638558025828;
        Fri, 03 Dec 2021 11:00:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m9sm2547869qkn.59.2021.12.03.11.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:00:25 -0800 (PST)
Date:   Fri, 3 Dec 2021 14:00:24 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Message-ID: <YappSLDS2EvRJmr9@localhost.localdomain>
References: <YaUH5GFFoLiS4/3/@localhost.localdomain>
 <87ee6yc00j.mognet@arm.com>
 <YaUYsUHSKI5P2ulk@localhost.localdomain>
 <87bl22byq2.mognet@arm.com>
 <YaUuyN3h07xlEx8j@localhost.localdomain>
 <878rx6bia5.mognet@arm.com>
 <87wnklaoa8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnklaoa8.mognet@arm.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 03, 2021 at 12:03:27PM +0000, Valentin Schneider wrote:
> On 30/11/21 00:26, Valentin Schneider wrote:
> > On 29/11/21 14:49, Josef Bacik wrote:
> >> On Mon, Nov 29, 2021 at 06:31:17PM +0000, Valentin Schneider wrote:
> >>> On 29/11/21 13:15, Josef Bacik wrote:
> >>> > On Mon, Nov 29, 2021 at 06:03:24PM +0000, Valentin Schneider wrote:
> >>> >> Would you happen to have execution traces by any chance? If not I should be
> >>> >> able to get one out of that fsperf thingie.
> >>> >>
> >>> >
> >>> > I don't, if you want to tell me how I can do it right now.  I've disabled
> >>> > everything on this box for now so it's literally just sitting there waiting to
> >>> > have things done to it.  Thanks,
> >>> >
> >>>
> >>> I see you have Ftrace enabled in your config, so that ought to do it:
> >>>
> >>>   trace-cmd record -e 'sched:*' -e 'cpu_idle' $your_test_cmd
> >>>
> >>
> >> http://toxicpanda.com/performance/trace.dat
> >>
> >> it's like 16mib.  Enjoy,
> >>
> >
> > Neat, thanks!
> >
> > Runqueue depth seems to be very rarely greater than 1, tasks with ~1ms
> > runtime and lots of sleeping (also bursty kworker activity with activations
> > of tens of µs), and some cores (Internet tells me that Xeon Bronze 3204
> > doesn't have SMT) spend most of their time idling. Not the most apocalyptic
> > task placement vs ILB selection, but the task activation patterns roughly
> > look like what I was thinking of - there might be hope for me yet.
> >
> > I'll continue the headscratching after tomorrow's round of thinking juice.
> >
> 
> Could you give the 4 top patches, i.e. those above
> 8c92606ab810 ("sched/cpuacct: Make user/system times in cpuacct.stat more precise")
> a try?
> 
> https://git.gitlab.arm.com/linux-arm/linux-vs.git -b mainline/sched/nohz-next-update-regression
> 
> I gave that a quick test on the platform that caused me to write the patch
> you bisected and looks like it didn't break the original fix. If the above
> counter-measures aren't sufficient, I'll have to go poke at your
> reproducers...
> 

It's better but still around 6% regression.  If I compare these patches to the
average of the last few days worth of runs you're 5% better than before, so
progress but not completely erased.

     metric         baseline   current      stdev           diff      
======================================================================
write_io_kbytes       125000     125000            0    0.00%
read_clat_ns_p99           0          0            0    0.00%
write_bw_bytes      1.73e+08   1.74e+08   5370366.50    0.69%
read_iops                  0          0            0    0.00%
write_clat_ns_p50   18265.60   18150.40       345.21   -0.63%
read_io_kbytes             0          0            0    0.00%
read_io_bytes              0          0            0    0.00%
write_clat_ns_p99   84684.80   90316.80      6607.94    6.65%
read_bw_bytes              0          0            0    0.00%
elapsed                    1          1            0    0.00%
write_lat_ns_min           0          0            0    0.00%
sys_cpu                91.22      91.00         1.40   -0.24%
write_lat_ns_max           0          0            0    0.00%
read_lat_ns_min            0          0            0    0.00%
write_iops          42308.54   42601.71      1311.12    0.69%
read_lat_ns_max            0          0            0    0.00%
read_clat_ns_p50           0          0            0    0.00%

Thanks,

Josef
