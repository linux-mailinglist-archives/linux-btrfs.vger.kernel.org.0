Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF951A5B98
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Apr 2020 01:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgDKXwF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Apr 2020 19:52:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40079 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgDKXwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Apr 2020 19:52:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id ca21so4841299edb.7
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Apr 2020 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=riax+nLluf8NRVF1efHR5pCLFuzxzoOKbHTtlgIT4ew=;
        b=krOVcV+ue9Ux5VK1aX6HFZbNoVaeQeWGJPt46ukGOeJC4uJOhzzjCUCiN8dThw7r7h
         fJgeb9nyQ6q7xSG8BsljbsUW9wd5+CmiCBrlNAc17XSB+3guS9hO5fW1BSjJ/3tP+hYC
         JxJ6/JotcWbqPMJ/OLcudjgqGCB3IKRfw8c7aobscuSHaMSiBP7/rx/fRX+QpgPmvYkt
         5kXgFa1SEp6bGiqxRHl+u6fbzP+rmlRa4Em0jqxx4KpZdfVSZOoJkDOIGZrPurNpO4VA
         SPwul/uKDr1cYhss0JSaPe5PZM7dXcmk7dp2RXqRYC9A6wirtUpUKW4XtvvhaJPiaOnR
         zl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=riax+nLluf8NRVF1efHR5pCLFuzxzoOKbHTtlgIT4ew=;
        b=jLwU7WY4FwxBUDfrbOgb3RGANHJdI2+rG+38iryJPiB3+mnxx5TjN7An26Gr1xtwlQ
         4kTG7jba7B6hPqyvo8ugssgCIPAnDaqudFMtUyLGgYJpI+0W314/aJ/DFpGgxa58xGWG
         864vGYt/eaMoHJ2m9YhLaBs1eQHJXC6vNiBNcnZoqqziOmqw0PXMi6Q9n1G5FG9JZWAq
         at8d7crTNL7hLQCnnEfOy3WyNkWWRs+FV7zKQqvu67S7DCqTZ3Bz/NyMWSMQ1T3/eQk0
         f9DtfQiKmjyTAZ1CZeLOX49HUVvhPQr2uBhNMol4kp36A18PVGshVtkySF/UAZmZ0jWS
         9oHw==
X-Gm-Message-State: AGi0PuZCykmXseIPBen8z45DvMp/CUF1zta0qBkA3rjqKenmrCyoXw3b
        fiR7yy4vnR/6p3OUiwczKrCcZWb4
X-Google-Smtp-Source: APiQypLa1tPojoSbcFIA5vRauWADXlw2D51tfxe0bIyBh1BTECIlACzuJuy11IN8xAIob0PEQG0m2g==
X-Received: by 2002:a05:6402:28b:: with SMTP id l11mr4822315edv.156.1586649122805;
        Sat, 11 Apr 2020 16:52:02 -0700 (PDT)
Received: from ?IPv6:2001:984:3171:0:126:e139:19f1:9a46? ([2001:984:3171:0:126:e139:19f1:9a46])
        by smtp.gmail.com with ESMTPSA id u13sm648846edi.82.2020.04.11.16.52.02
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 16:52:02 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Oliver <oliver111333777@gmail.com>
Subject: cancel resize
Message-ID: <1c779cba-5d1c-0bca-38bf-af5cd572a9d0@gmail.com>
Date:   Sun, 12 Apr 2020 01:52:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I've made a stupid mistake. I wanted to reduce a disk with 1990m, but 
instead resized it to 1990m.

btrfs fi resize 2:1990m /btrfs

It will take forever and might fail in the end, as I might not have 
enough space avaiable.

How do I cancel this operation ? I can see cancel operations for other 
commands, but not this one.

thanks,
Oliver
