Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E727B89
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 13:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfEWLTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 07:19:33 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:33122 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfEWLTd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 07:19:33 -0400
Received: by mail-it1-f177.google.com with SMTP id j17so8022134itk.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2019 04:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fY3WqLaToD/hU/bJ/qxP6n0psJJdqxMLl/kvgJ09Vrk=;
        b=LOUOyp9BLTAfWb4stTyg0oFWyKv1WxVUdpJxOcYajFM0zvBmkfRGIEl3PELdWwGGSb
         kBhYrPDrpo2kWO4JzVJI1/G61ozGxurtzVkEqzLXROFvPkFFRF692JCHJfr+y+rg8ErH
         w247jbbTYmUO2IQSL+77QZT2SAbJHyLfuQR/fvy5yZ1PDB9tn7xczfwEy1eDVcIXywhX
         qvgExYt34c2lIcsJR+SBZ4W8zW+JorBB75mpQIVwD9+/Uu7anj7a9wRls+MpNjDIxUcD
         h9aTpa4QSP/p1Tu2/lkF4JfUhUK3iwmqO6DCHvDc5M8hFSvewPJmLobtjLBGvzkmdh7P
         ve+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fY3WqLaToD/hU/bJ/qxP6n0psJJdqxMLl/kvgJ09Vrk=;
        b=E19PRwJlO0KtWczay2VKowHGdwREQs6zVDiRj1CMhd3XZ6i3Rt98O8xIn85aKSlRxv
         5+Sk+nEz+hL+Uox6d+qTNqtD/P6O+4oYbzPCzfRHN38eDvo202+ymFBauHxnyPyaNqpy
         biufE7vs3ZvlNXgDDmxrptj/kmyqMMFFpMtReHy7Q9bpcihjop+KT47GRz+EJXYvUx3x
         jbkcMcuYruiJw6n1ifS6RDEEl3xvGiFiCLNJMRBdoAxeQl9j9/QeAkjCwq1g1MBR0HIE
         UaOIkm4SaGG4TFTj21lwCxJKlefcwP/rYtrUJgRz3OQ3CJO+N68c0ouS2IpBHmp6ebk2
         dkTA==
X-Gm-Message-State: APjAAAUM4MzJMhwnHPLIYrpR/WgwWLvkka77MmlJz8Sbwmj1yhKZNyS5
        1+GEDTdTpxWipuN/I8rf+IdJYsLUgE5I+Q==
X-Google-Smtp-Source: APXvYqxwEdu2HEIeGXHx//b+9vsB0qBo264yTd/DGLGaUHwfW6cWAB0VrSI9JGRvTBgaeYTZHzSC8Q==
X-Received: by 2002:a02:1146:: with SMTP id 67mr62396469jaf.10.1558610372231;
        Thu, 23 May 2019 04:19:32 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id f71sm5755594itc.5.2019.05.23.04.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:19:31 -0700 (PDT)
Subject: Re: Citation Needed: BTRFS Failure Resistance
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com>
Date:   Thu, 23 May 2019 07:19:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-05-22 14:46, Cerem Cem ASLAN wrote:
> Could you confirm or disclaim the following explanation:
> https://unix.stackexchange.com/a/520063/65781
> 
Aside from what Hugo mentioned (which is correct), it's worth mentioning 
that the example listed in the answer of how hardware issues could screw 
things up assumes that for some reason write barriers aren't honored. 
BTRFS explicitly requests write barriers to prevent that type of 
reordering of writes from happening, and it's actually pretty unusual on 
modern hardware for those write barriers to not be honored unless the 
user is doing something stupid (like mounting with 'nobarrier' or using 
LVM with write barrier support disabled).
