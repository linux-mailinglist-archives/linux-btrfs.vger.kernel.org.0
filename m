Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5551D5181BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiECJ6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiECJ6b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 05:58:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4182C34BA4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651571697;
        bh=ihFjC4CjzmV+jo+l4bdV9Ilf+cRYDQFT+onDv0DuIVM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=LDakGyFQcyLnxD1kLJCtxSPIYA6jhgb9DmHVT6Wox1eR9axtsaKrXgHO2JAYPiasj
         9hjHk1Z637Hhov4stv7efk0ldH9yJ6ckkJXYiSrWKYm0UW1PpiI4BeJnOxCEPw53yP
         qMTQ9wP1tF6UEgwT3qVBZnrUY8EBYOqUjg1AdAcw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHnm-1o5xMY35eU-00tkZo for
 <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 11:54:57 +0200
Message-ID: <d018c2e9-b07c-6a2d-9819-810ce81ad24c@gmx.com>
Date:   Tue, 3 May 2022 17:54:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: cannot mount btrfs root partition
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220503102001.271842da4933a043ba106d92@lucassen.org>
 <20220503083206.GI15632@savella.carfax.org.uk>
 <20220503104550.16d2465877beb89f713485c2@lucassen.org>
 <20220503090842.GJ15632@savella.carfax.org.uk>
 <20220503113427.3a192c5daf6197aa3b6c93bc@lucassen.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220503113427.3a192c5daf6197aa3b6c93bc@lucassen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I3VKdkFYaZGyyj0a5sZB0lmOyGbfg5KDmf3N/gy65KOAoIdCRdX
 XulxBeUspKqmkXDTx8AZSaClG1ZSdq/v/lNsc7yRrsON60XxcerGO3AsGGCl0batjUghvbv
 WI+j/QOzgkOU54PXmT9qLOxpqVrBEDmNe1cMUE3x+EBNA+0Qtupd6expygMYcyfgu1URHOV
 vxnRh2zaJWzK6qdNiuTwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tp4cOxACMs0=:lz7+rlQ6p2oL0iLWZbyRdB
 TLpW4jx2HoK2z8FzkdQgXAT4T2F21tWSAsy/A4rwpmgHReLrUG+vqWg5xldwMrGZZOYrXKmjA
 5T0yJO2K+dFTY4e7VgzgTM8tsIAxh8sSsI43GIo/7S/SRkzII0awjoKLyxTADm/Xkn9pQkjRc
 meZD6flByoafjK/muEoLVjf7Rf6HLeQafufG5HvKKZWqJygCRHkBdDikEo8XZOwZVKV42PE82
 pG4MCrhO8E3gP7YGxfEr4HR+dgxHSYh8EkndkMgR+7j6JjSLR2WepRi9QnOXrZUmr+96IkThv
 NgYAj1xYVFBd78S4YGPZgpD4bPkp0e0GGM/v21ebyC5VCvY9y3dBov/3ZPL43KfyJ8JU/+Qsk
 F10rEI5BwyJNWFiEVz77J00Djoud9hRSEK2TNIAIg2Y8kb5xRjw+AIU6OeYnQqW8WPKNNT1Vb
 Q7YB0xC1kKee7cKm3OycgknaO+uKbUAS3HAOEPgb9LhfktQmHiX9vxpXVaIajt7bqurXHJPDM
 kMfZBfiZ5nUfh5uEpT99jpgSc3RwoVisu+DJH2FVYo+QOD4k2j3kW5P/s7YWcCdNprH4uOwTH
 wqLgLGz73GklHgkUtofOzgpKjrDu7DovAVS7nWJDQkW7w0ifU3h/5KT2kVfz/CHBSMncZVrtS
 bPRI7Y9mL3QTnlM7kA7c8zdYBx01Tc87u6lJT/3QztgeExb33HjHnHasRtN9kVVv14/b259wf
 nODvH4XEd2WYzgpTOEh2RznnxAlwCIl9zhFAaZ2EQ3GTXyXoMWXQMrHAuXvjKdQxYFA1mg6Al
 B9o7pHoOQDoMzeJkJ9fTcgaZzanNFtpa0DwLszYxC9cNeLUeEP+3mOR7Bm5Izli8ydohCoRnu
 PLIFcTOONCdJJWkkQ9RofXJebGJdYD7Gq44APuq1acIvFvkd4gi/vX0s+f36VgtfTLpaQZezl
 KyU/Ug2+ko49joUH/NA4+Uy222YNp1zXlyv1xvTAIEzWfn6Vk0gvgOHstVLWUHeRHzPRjZmVO
 eKMYvq2OwGzRh4INe7MvdQ64mtLC610AFsS8aHAGRHm2thAAg1wHTcDxZ25OcBMYbxaSKndyW
 mM6XSgtjQ6cit0=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/3 17:34, richard lucassen wrote:
> On Tue, 3 May 2022 10:08:42 +0100
> Hugo Mills <hugo@carfax.org.uk> wrote:
>
>>     For the single-drive case, I don't know why that's not working. Is
>> the error message the same with that as for the multi-device FS?
>
> Oops, error, mea culpa, it's an SD card and I forgot the "rootwait"
> option. It boots into btrfs now!
>
> About the option to specify the devices explicitely, is this the right
> syntax to tell the kernel what to do?
>
> append=3D"root=3D/dev/sda6 rootflags=3Ddevice=3D/dev/sda6,device=3D/dev/=
sdb6"

Since you only have two devices in the fs, you can skip the one in the
root=3D, just by:

root=3D/dev/sda6 rootflags=3Ddevice=3D/dev/sdb6

You can test with all devices forgot:

# btrfs devices scan -u /dev/sda6
# btrfs devices scan -u /dev/sdb6
# mount /dev/sda6 -o device=3D/dev/sdb6 /mnt/btrfs

Thanks,
Qu
>
> R.
>
