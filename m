Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB20702BBD
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbjEOLoJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 07:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbjEOLmH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 07:42:07 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DCF172B
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 04:37:27 -0700 (PDT)
Received: from [IPV6:2001:a61:6143:6401:ff2e:a0e1:456a:bd5b] (unknown [IPv6:2001:a61:6143:6401:ff2e:a0e1:456a:bd5b])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sbabic@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E6C5C86371;
        Mon, 15 May 2023 13:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684150645;
        bh=F1en7jVwGHL6M7oNgByQXYWo+2jg0MMoXOJZeQlXSjM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L6v/o98RZF1Ue2Vn7RAvulUdkrh1MHhYTyYhrJPSkkS9w3cO8s5ETjUt9sTNhbbSY
         GQ53rNNQpucsmXs5kpaNCRgshzLpdt/PFkBzzyJ01y8DPwnMrVz6bm3mH8mU4l7Nhk
         +HaLeRUkX0qN+zItLDKs2/xrPDWxVWp28h+NO5fNUGRVy+y6sXB62BIaqVUje2dSvQ
         O51lkuZe8RIhjXCZjnPU94wPL7qhtvhf5SvEDGYVqZNQ0pumG9sSmZz5XH2tf+mpAj
         sIC3fEEyNq1x1ffrlRuNLQA7DBJLXOHyhWIUNjb99rGtAf817Ek5PueAeRja5vyWzD
         iaDBFta9KUV+w==
Message-ID: <f83b6f51-1ca9-19df-18d1-24457d45b095@denx.de>
Date:   Mon, 15 May 2023 13:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] Makefile: add library for mkfs.btrfs
Content-Language: de-DE
To:     dsterba@suse.cz, Stefano Babic <sbabic@denx.de>
Cc:     linux-btrfs@vger.kernel.org
References: <20230514114930.285147-1-sbabic@denx.de>
 <20230515105958.GF32559@twin.jikos.cz>
From:   Stefano Babic <sbabic@denx.de>
In-Reply-To: <20230515105958.GF32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On 15.05.23 12:59, David Sterba wrote:
> On Sun, May 14, 2023 at 01:49:30PM +0200, Stefano Babic wrote:
>> Even if mkfs.btrfs can be executed from a shell, there are conditions
>> (see the reasons for the creation of libbtrfsutil) to call a function
>> inside own applicatiuon code (security, better control, etc.).
>>
>> Create a libmkfsbtrfs library with min_mkfs as entry point and the same
>> syntax like mkfs.btrfs. This can be linked to applications requiring to
>> create the filesystem.
>>
>> Signed-off-by: Stefano Babic <sbabic@denx.de>
>> ---
>>
>> This requires some explanation. Goal is to export mkfs.btrfs as library
>> to let it be be called from an application. There are use cases in embedded systems
>> where this is desired and the reasons are exactly the same
>> that lead to libbtrfsutil. I can shell out mkfs.btrfs, but this is not
>> the best option (security if shell is compromised, dependency that mkfs is available,
>> having a self contained application, output format not parsable, etc.).
>>
>> For all these reasons, a library that creates a btrfs filesystem is desired.
>> The patch here just export mkfs.btrfs in the busybox way, that is exports mkfs_main(),
>> and just builds a library. It does not touch existing code (Makefile).
>>
>> Agree that this can be just used by other Open Source projects that are compliant with
>> GPLv2, but this is exactly my use case :-).
>>
>> I would like to know if such as extension can be accepted, even if I know
>> this is not a topic for most Linux distributions.
> 
> The use case is reasonable, but creating a separate library is not a good
> solution IMHO. There needs to be stable versione API, symbol versioning
> for backward compatibility. If you already link against libbtrfsutil
> then the mkfs should be provided there.

Fully agree - it was just to show the use case and reason. If such a 
call was available in libbtrfsutil, it would be perfect - not only for 
my use case (a GPLv2 project), but also for application whose sources 
are not available.

> 
> Do you need to create multi device filesystem?

On embedded devices, not. A single device is enough.

> Compared to a single
> device the API would be easier, the one device file descriptor and the
> flags and numeric parameters like nodesize. The string interface in
> argc/argv is flexible and extensible but not a real library API.

Agree. It is not an API at all.

> 
> So for a single device we can extract the functions from mkfs and wrap
> them to a single call. The libbtrfsutil code is sepate so it would need
> a rewrite and it also has a different license, that's another thing to
> consider.

It has a separate license, that is for me just an advantage. But most 
code in kernel_shared, etc used by mkfs is GPLv2, thet means it should 
be relicensed or a new implementation should be done to be part of 
libbtrfsutil.

Best regards,
Stefano


-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================

