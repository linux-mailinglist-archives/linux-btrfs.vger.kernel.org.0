Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7896130A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 07:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJaGpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 02:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaGp2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 02:45:28 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E50E2F0
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Oct 2022 23:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1667198723; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hmzu9xOsDNIrnGc9i02gHMW38ht7Yg8GcvO+/pOCrwWZt7yGW0lJNF2TluiRYE40lqZu6Vb8FBGEKMcL5p2k7vZdI+PsbjQZG558P8855J2VcbKwWLIhqIIpyEPaXyPHgefuFduEcqCoXTTnYSJkR/I784UVce5nzC0a5vi3NMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1667198723; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=rCDwOs/p0YVVy3FfNM5nRb9mT99j4FBTJXawrqz/VPw=; 
        b=YjS/rG5UlQb2ik9TQqe1CTXbjfsi7cW2kT5QYmoeSFV+CG7KQ/YgygJdhzS5esmjMQi7WcKCRJSRjUXZX03Ss53y/6sS3EJJB/ImAvAMon2KiJtIXqJjKK90e7TIw2c9rqVXHSC2Y5HWRBgMkhloEYRuaGlH23R3X948AMQ96m4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:to:cc:from:subject:content-type; 
  b=AQ9NiEXNNHIl3Nx47gKeAtZsz0AgNW/70gMtyYjzQUjvKY6eLK0jeqcMNbkW3XmoHStgWWEoXbwg
    s5Nwc9NJ+VN+U2zyQV69iy/jTwH9+1R0Dyjghadcm3BGOLMTIspB  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1667198723;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=rCDwOs/p0YVVy3FfNM5nRb9mT99j4FBTJXawrqz/VPw=;
        b=eu+XARq/o03OmgOosh1fvK7myAWuWXcR16SMm9zaiuqIyu1H9aeX2t+E7AgtTWMd
        ik6C9pYYOyISs/gfSOSGm+w0TE0Ck6GmqNh/mD+mVzH05H2X/t/vE4MnPYVI9YBFaDh
        B/87hsgDspSyMRVx6OcJlXIWT3qvkgRQmU3hnO1M=
Received: from [192.168.0.103] (58.247.201.220 [58.247.201.220]) by mx.zohomail.com
        with SMTPS id 1667198721612907.6393584074159; Sun, 30 Oct 2022 23:45:21 -0700 (PDT)
Message-ID: <a593d5a2-bfbc-f1e9-ba28-842d2162cc6e@zoho.com>
Date:   Mon, 31 Oct 2022 02:45:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
From:   hmsjwzb <hmsjwzb@zoho.com>
Subject: How about btrfs on Android phone?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi BTRFS developers,

Recently I was wondering is it possible to use btrfs as Android phone default filesystem.

[1] Some concept in this email.
    UFS: Universal Flash Storage
    UFS device: A kind of flash device which handle SCSI command
    UFS firmware: A kind of software handle the SCSI command and deliver result
    LBA: logical block address

[2] How does this idea come out ?
    We all have the exprience that the longer an Android device is used the slower it will be.
    I think it may have some relationship with fragmentation.
    
    In the UFS4.0 protocol, China Android phone vendor Xiaomi present a technology named FBO (File Based Optimization).
    The main idea of FBO is to map the discontinuous LBA to continuous physical address managed by UFS firmware.
    
    LBA:                | 1 | 2 |   | 4 | 5 |   | 7 | 8 |
    Physical address:   | 1 | 2 | 4 | 5 | 7 | 8 |   |   |
    
    As we can see from above, after the FBO, the three discontinuous LBA chunk are mapped into one continuous
    chunk in physical address by firmware. So the UFS firmware can merge this into one single read operation.

    We can see that fragmentation is a real issue for Android phone vendors.
    As for FBO, I believe this technology has some limitations. It may not allocate physical continuous physical
    address for all logical continuous data.
    
    So I believe defragmentation is important for Android phone filesystems. 
     
[3] What's the problem with current Android filesystem F2FS ?
    (a) The file mapping table in F2FS.
        In my opinion, the design of F2FS mapping table is came from MINIX. I think this direct, indirect mapping
        design is some kind of encourage fragementation.
        
    (b) Lack of new filesystem feature.
        I think some new features in btrfs is difficult to implement in F2FS filesystem. For example, lack of delay
        allocation may make the fragmentation status on device even worse. Maybe it is possible to implement some new
        features. But it will make the code complex and hard to debug.
        
[4] What make btrfs attractive to me ?
    (a) Online filesystem defragmentation
        I know the online filesystem defragmentation is not mature by now. But I believe it can be mature in the future.
        If an Android phone uses online filesystem defragmentation in the middle night, the user exprience may be improved
        the next day.
        
    (b) New features.
        New features like COW may help application to save storage space.
        Checksums on data and metadata.
        ...
        
[5] The performance between F2FS and btrfs on phone.
    I haven't test the performance between F2FS and btrfs on Android phone. But I think F2FS has advantages. Because it has
    many flash based optimizations.
    
    But I believe btrfs can do those optimizations too.
    
[6] Seeking Some advice if we start to do some researches on this aspect.
    (a) I want to know is there any issue I haven't taken into concern.
    (b) How to measure two filesystem performance both in short term and long term? Is there any existing tool or we need to
        develop some tools for it.
        
Thanks
