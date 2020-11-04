Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03E2A6A38
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 17:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgKDQsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 11:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgKDQsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 11:48:15 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89156C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 08:48:15 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b18so19867272qkc.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 08:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kUS3XTLjRL4r+DDiJpZewdtOiODbkPkVa7NDwxrrZWk=;
        b=2ReE8EtMLCH34nii75jF2gflJkSNbO7DmPLxyjONRJioHrCxAz1XujaukebTaIy8DU
         o/PKUHBzu++M0+2/H08igiFg+p1fMcgVglEeNGhCe3/PDs55yvYwsSIpRQOyrby9VUX+
         ikV7MCQq6VZvb/SAS3Z6hWtao5rZAcvkzIEAbeOifBp5KPQf6elm5oOktcVS/LdRUkOD
         Pq7EnWkVYPmV1JnBuqG7jCwHs3ycIh2TDJuytdmC70Fm4diNBNLKFJhZ/+GRDGv9IhaM
         dtTwwXIIOULq7thfdjQtnmrTaZF0U2dbveINpCmpTcH/D8QY79yfRsKUseB4AC4HmvGW
         BRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUS3XTLjRL4r+DDiJpZewdtOiODbkPkVa7NDwxrrZWk=;
        b=ZYTM68y4V9LPfgkgkWtjOrjUhuRn6tEwlRQvY0rBZUM0kv2e8mjwKjWRHmJnhxYQxR
         ynfo3szaOBw1ZZBN+q8LIkiwXFe7jJQfeD2qflQYUHZ7YWnvd7owiQuwGZNohmW9rPGF
         X3g8b2qWNzIpwkE7ENFx6DayFL4Kbafi14J33fzdqJWJGAcs6YuKePzi7d2+VayzvDaQ
         oE6dLKoR+P9Wg4k1wW9eOovVixccfHqJbXpAtWU4tH2BmDdRKOLffpNXLYnOTlE21Mtx
         NUumm5HNs8jTtYzm/NM5B8d5p2sic+fM/tCZs3X5ut8cWJXBazeSp+ztvHud36/LowaE
         J0YQ==
X-Gm-Message-State: AOAM5328MxLmob/0YcsgFS8dO/rtvUW/OlL4t878Ad1iXmuumkqjblrX
        92yZKv1YPI0PIWsrLWNrjCqDMOmTob9fwg==
X-Google-Smtp-Source: ABdhPJw2C2lckas80g3x/zgFby+RxpCVCVCMdOPgrH0yc0yFBg4uciTURIkJAo02Y0Oe3hJFRqhKKw==
X-Received: by 2002:a37:4796:: with SMTP id u144mr409153qka.235.1604508494095;
        Wed, 04 Nov 2020 08:48:14 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::1180? ([2620:10d:c091:480::1:c888])
        by smtp.gmail.com with ESMTPSA id y187sm2841690qka.116.2020.11.04.08.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 08:48:13 -0800 (PST)
Subject: Re: [btrfs] 96bed17ad9: fio.write_iops -59.7% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        linux-btrfs@vger.kernel.org
References: <20201104061657.GB15746@xsang-OptiPlex-9020>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ec5733c4-9d02-5057-3040-8dcf566efd83@toxicpanda.com>
Date:   Wed, 4 Nov 2020 11:48:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104061657.GB15746@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 1:16 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -59.7% regression of fio.write_iops due to commit:
> 
> 
> commit: 96bed17ad9d425ff6958a2e6f87179453a3d76f2 ("btrfs: simplify the logic in need_preemptive_flushing")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 
> in testcase: fio-basic
> on test machine: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
> with following parameters:
> 
> 	disk: 1SSD
> 	fs: btrfs
> 	runtime: 300s
> 	nr_task: 8
> 	rw: write
> 	bs: 4k
> 	ioengine: sync
> 	test_size: 256g
> 	cpufreq_governor: performance
> 	ucode: 0x4002f01
> 
> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
> test-url: https://github.com/axboe/fio
> 

I generally ignore these reports, but since it's FIO I figured at least the test 
itself was valid.  However once again I'm unable to reproduce the results

linus master:

task_0: (groupid=0, jobs=8): err= 0: pid=38586: Wed Nov  4 08:13:36 2020
   write: IOPS=168k, BW=655MiB/s (687MB/s)(192GiB/300001msec); 0 zone resets
     clat (usec): min=26, max=786, avg=47.15, stdev= 7.21
      lat (usec): min=26, max=786, avg=47.21, stdev= 7.21
     clat percentiles (nsec):
      |  1.00th=[31872],  5.00th=[35584], 10.00th=[37632], 20.00th=[40704],
      | 30.00th=[43264], 40.00th=[45312], 50.00th=[47360], 60.00th=[48896],
      | 70.00th=[50944], 80.00th=[52992], 90.00th=[56064], 95.00th=[59136],
      | 99.00th=[65280], 99.50th=[68096], 99.90th=[74240], 99.95th=[77312],
      | 99.99th=[88576]
    bw (  KiB/s): min=63752, max=112864, per=12.50%, avg=83810.53, 
stdev=3403.48, samples=4792
    iops        : min=15938, max=28216, avg=20952.61, stdev=850.87, samples=4792
   lat (usec)   : 50=65.73%, 100=34.27%, 250=0.01%, 500=0.01%, 750=0.01%
   lat (usec)   : 1000=0.01%
   cpu          : usr=2.22%, sys=97.77%, ctx=5054, majf=0, minf=63
   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
      issued rwts: total=0,50298940,0,0 short=0,0,0,0 dropped=0,0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   WRITE: bw=655MiB/s (687MB/s), 655MiB/s-655MiB/s (687MB/s-687MB/s), io=192GiB 
(206GB), run=300001-300001msec

kdave/for-next-20201104
task_0: (groupid=0, jobs=8): err= 0: pid=6652: Wed Nov  4 08:41:52 2020
   write: IOPS=180k, BW=705MiB/s (739MB/s)(207GiB/300001msec); 0 zone resets
     clat (usec): min=17, max=10603, avg=43.91, stdev= 9.62
      lat (usec): min=17, max=10603, avg=43.98, stdev= 9.62
     clat percentiles (nsec):
      |  1.00th=[25984],  5.00th=[31104], 10.00th=[33536], 20.00th=[37120],
      | 30.00th=[39168], 40.00th=[41216], 50.00th=[43264], 60.00th=[45824],
      | 70.00th=[47872], 80.00th=[50944], 90.00th=[54528], 95.00th=[57600],
      | 99.00th=[64768], 99.50th=[68096], 99.90th=[74240], 99.95th=[78336],
      | 99.99th=[90624]
    bw (  KiB/s): min=66760, max=123160, per=12.50%, avg=90221.11, 
stdev=9052.52, samples=4792
    iops        : min=16690, max=30790, avg=22555.24, stdev=2263.14, samples=4792
   lat (usec)   : 20=0.01%, 50=77.24%, 100=22.75%, 250=0.01%, 500=0.01%
   lat (usec)   : 750=0.01%, 1000=0.01%
   lat (msec)   : 2=0.01%, 4=0.01%, 20=0.01%
   cpu          : usr=1.67%, sys=98.31%, ctx=4806, majf=0, minf=68
   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
      issued rwts: total=0,54134917,0,0 short=0,0,0,0 dropped=0,0,0,0
      latency   : target=0, window=0, percentile=100.00%, depth=32

Run status group 0 (all jobs):
   WRITE: bw=705MiB/s (739MB/s), 705MiB/s-705MiB/s (739MB/s-739MB/s), io=207GiB 
(222GB), run=300001-300001msec

So instead of -60% iops regression, I'm seeing a 7% iops improvement.  The only 
difference is that my machine doesn't have 192 threads, it has 80.  Thanks,

Josef
