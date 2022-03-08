Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623A34D16EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 13:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346696AbiCHMMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 07:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbiCHMM3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 07:12:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00B943ED2E
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 04:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646741492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=My+rA77TnRiVMf0r++5rhnoLzDzN0CO6+Ek5CVVdjaA=;
        b=R8/o+q3f8pQTTYgek0AZHFkRiZO/oCcVjqARAqNvqovA/w8IgVRnQJGWfSXA9pIgdgEOn1
        1EGGgq0JxY6jHN06M2aLKmEJz5F1mSQuoT/9ieK8WUYY87xllaWkGL2xSWBVxSwJYbJknT
        294tG9hXplTwWT2PbnmQ+5hj0l2z9M8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-sfWENGuEOqOaOLLs3En7jQ-1; Tue, 08 Mar 2022 07:11:30 -0500
X-MC-Unique: sfWENGuEOqOaOLLs3En7jQ-1
Received: by mail-wr1-f70.google.com with SMTP id a16-20020adff7d0000000b001f0473a6b25so5129000wrq.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 04:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=My+rA77TnRiVMf0r++5rhnoLzDzN0CO6+Ek5CVVdjaA=;
        b=6Ws8x+I9udPf9r5teiSHOnle990X4ZYEjDL3+0+sDyM/IP0JGxZzm7wlYGgFDflxLS
         2W242mOzwGggV1SsxcXBtakZCa3krXRSGI5r+CFMPzi9r/sgdBl5DtzEgkDss+8ejd7P
         K3Dig/McBpDUYoSgJTe2XqD1ww5rFZL2BbpSiPNpIP5wZwPBlSAV8MOXmfJ47fHAC0Ay
         DYCLkHZj0b5WsiQM2aq8MEb57h4Uu9RnVe0wSFzhaCXSnLm5a/Vdq79f/KQnGxjq1M83
         ZFX0t7XJf+qdkJ4mLLbJbXfrald4MkdxMfoCSf5boOn6Qxt/ZD5Lyw8nhIlKNMeKMwl5
         IH+A==
X-Gm-Message-State: AOAM532w3MaftEMbk+TFTX23Cq8FHJjwXrFP72etZ6DN/6B+6XS6MwpY
        CKwK6t1G8F9fUC3Q0UduLlUq3fK0/xfmstqAxlCWtg0or4QPY12kVancLIqPBZ5cUN1U2JbvDAm
        lR/Ymi040T1ji1dBbLmxiBIk=
X-Received: by 2002:a5d:648c:0:b0:1ed:b04d:300 with SMTP id o12-20020a5d648c000000b001edb04d0300mr9479642wri.347.1646741489653;
        Tue, 08 Mar 2022 04:11:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyS0RIaqKLeHkgO2t9OYkaaKQ8wNAplyKf1ZSIpNTCQ7/fdrBVSMK96sCf+QkB9iBPO2ZQxCQ==
X-Received: by 2002:a5d:648c:0:b0:1ed:b04d:300 with SMTP id o12-20020a5d648c000000b001edb04d0300mr9479613wri.347.1646741489376;
        Tue, 08 Mar 2022 04:11:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id u15-20020a056000038f00b001f1e57a74e2sm7487160wrf.4.2022.03.08.04.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 04:11:28 -0800 (PST)
Message-ID: <81f2f76d-24ef-c23b-449e-0b8fdec506e1@redhat.com>
Date:   Tue, 8 Mar 2022 13:11:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
 <2266e1a8-ac79-94a1-b6e2-47475e5986c5@redhat.com>
Organization: Red Hat
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
In-Reply-To: <2266e1a8-ac79-94a1-b6e2-47475e5986c5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08.03.22 09:37, David Hildenbrand wrote:
> On 08.03.22 09:21, David Hildenbrand wrote:
>> On 08.03.22 00:18, Linus Torvalds wrote:
>>> On Mon, Mar 7, 2022 at 2:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>>>>
>>>> After generic_file_read_iter() returns a short or empty read, we fault
>>>> in some pages with fault_in_iov_iter_writeable(). This succeeds, but
>>>> the next call to generic_file_read_iter() returns -EFAULT and we're
>>>> not making any progress.
>>>
>>> Since this is s390-specific, I get the very strong feeling that the
>>>
>>>   fault_in_iov_iter_writeable ->
>>>     fault_in_safe_writeable ->
>>>       __get_user_pages_locked ->
>>>         __get_user_pages
>>>
>>> path somehow successfully finds the page, despite it not being
>>> properly accessible in the page tables.
>>
>> As raised offline already, I suspect
>>
>> shrink_active_list()
>> ->page_referenced()
>>  ->page_referenced_one()
>>   ->ptep_clear_flush_young_notify()
>>    ->ptep_clear_flush_young()
>>
>> which results on s390x in:
>>
>> static inline pte_t pte_mkold(pte_t pte)
>> {
>> 	pte_val(pte) &= ~_PAGE_YOUNG;
>> 	pte_val(pte) |= _PAGE_INVALID;
>> 	return pte;
>> }
>>
>> static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>> 					    unsigned long addr, pte_t *ptep)
>> {
>> 	pte_t pte = *ptep;
>>
>> 	pte = ptep_xchg_direct(vma->vm_mm, addr, ptep, pte_mkold(pte));
>> 	return pte_young(pte);
>> }
>>
>>
>> _PAGE_INVALID is the actual HW bit, _PAGE_PRESENT is a
>> pure SW bit. AFAIU, pte_present() still holds:
>>
>> static inline int pte_present(pte_t pte)
>> {
>> 	/* Bit pattern: (pte & 0x001) == 0x001 */
>> 	return (pte_val(pte) & _PAGE_PRESENT) != 0;
>> }
>>
>>
>> pte_mkyoung() will revert that action:
>>
>> static inline pte_t pte_mkyoung(pte_t pte)
>> {
>> 	pte_val(pte) |= _PAGE_YOUNG;
>> 	if (pte_val(pte) & _PAGE_READ)
>> 		pte_val(pte) &= ~_PAGE_INVALID;
>> 	return pte;
>> }
>>
>>
>> and pte_modify() will adjust it properly again:
>>
>> /*
>>  * The following pte modification functions only work if
>>  * pte_present() is true. Undefined behaviour if not..
>>  */
>> static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>> {
>> 	pte_val(pte) &= _PAGE_CHG_MASK;
>> 	pte_val(pte) |= pgprot_val(newprot);
>> 	/*
>> 	 * newprot for PAGE_NONE, PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX
>> 	 * has the invalid bit set, clear it again for readable, young pages
>> 	 */
>> 	if ((pte_val(pte) & _PAGE_YOUNG) && (pte_val(pte) & _PAGE_READ))
>> 		pte_val(pte) &= ~_PAGE_INVALID;
>> 	/*
>> 	 * newprot for PAGE_RO, PAGE_RX, PAGE_RW and PAGE_RWX has the page
>> 	 * protection bit set, clear it again for writable, dirty pages
>> 	 */
>> 	if ((pte_val(pte) & _PAGE_DIRTY) && (pte_val(pte) & _PAGE_WRITE))
>> 		pte_val(pte) &= ~_PAGE_PROTECT;
>> 	return pte;
>> }
>>
>>
>>
>> Which leaves me wondering if there is a way in GUP whereby
>> we would lookup that page and not clear _PAGE_INVALID,
>> resulting in GUP succeeding but faults via the MMU still
>> faulting on _PAGE_INVALID.
> 
> 
> follow_page_pte() has this piece of code:
> 
> 	if (flags & FOLL_TOUCH) {
> 		if ((flags & FOLL_WRITE) &&
> 		    !pte_dirty(pte) && !PageDirty(page))
> 			set_page_dirty(page);
> 		/*
> 		 * pte_mkyoung() would be more correct here, but atomic care
> 		 * is needed to avoid losing the dirty bit: it is easier to use
> 		 * mark_page_accessed().
> 		 */
> 		mark_page_accessed(page);
> 	}
> 
> Which at least to me suggests that, although the page is marked accessed and GUP
> succeeds, that the PTE might still have _PAGE_INVALID set after we succeeded GUP.
> 
> 
> On s390x, there is no HW dirty bit, so we might just be able to do a proper
> pte_mkyoung() here instead of the mark_page_accessed().
> 

Something hacky like this should be able to show if what I suspect is the case.
It compiles, but I didn't actually test it.


From fee26d7bd90e219688c29bbe174e7a23d5e2dfd3 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 8 Mar 2022 12:51:26 +0100
Subject: [PATCH] mm/gup: fix buffered I/O on s390x with pagefaults disabled

On s390x, we actually need a pte_mkyoung() instead of a
mark_page_accessed() when doing a FOLL_TOUCH to clear the HW invalid bit
in the pte and allow subsequent accesses via the MMU to succeed without
triggering a pagefault.

Otherwise, buffered I/O will loop forever because it will keep stumlbing
over the set HW invalid bit, requiring a page fault, which is disabled.

Reported-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a9d4d724aef7..d6c65474ed72 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -592,10 +592,27 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			set_page_dirty(page);
 		/*
 		 * pte_mkyoung() would be more correct here, but atomic care
-		 * is needed to avoid losing the dirty bit: it is easier to use
-		 * mark_page_accessed().
+		 * is needed for architectures that have a hw dirty bit, to
+		 * avoid losing the dirty bit: it is easier to use
+		 * mark_page_accessed() for these architectures.
+		 *
+		 * s390x doesn't have a hw reference/dirty bit and sets the
+		 * hw invalid bit in pte_mkold(), to catch further references.
+		 * We have to update the pte via pte_mkyoung() here to clear the
+		 * invalid bit and mark the page young; otherwise, callers that
+		 * rely on not requiring a MMU fault once GUP(FOLL_TOUCH)
+		 * succeeded will loop forever because the page won't be
+		 * actually accessible via the MMU.
 		 */
-		mark_page_accessed(page);
+		if (IS_ENABLED(CONFIG_S390)) {
+			pte = pte_mkyoung(pte);
+			if (!pte_same(pte, *ptep)) {
+				set_pte_at(vma->vm_mm, address, ptep, pte);
+				update_mmu_cache(vma, address, ptep);
+			}
+		} else {
+			mark_page_accessed(page);
+		}
 	}
 	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
 		/* Do not mlock pte-mapped THP */
-- 
2.35.1



We should probably generalize this, using an ARCH config that says that we
don't have HW dirty bits and can do a pte_mkyoung() here without losing
any concurrent updates to the pte via the hw.

Further, I wonder if we might have to do a pte_mkdirty() in case of FOLL_WRITE
for these architectures as well, instead of going via the set_page_dirty().
Could be that that might be required as well here, haven't looked into the
details.

The follow_trans_huge_pmd()->touch_pmd() case should be fine I guess,
and it does both, the pmd_mkyoung and the pmd_mkdirty.

-- 
Thanks,

David / dhildenb

